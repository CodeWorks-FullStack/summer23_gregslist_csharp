
namespace gregslist_csharp.Repositories;

public class CarsRepository
{

  private readonly IDbConnection _db;

  public CarsRepository(IDbConnection db)
  {
    _db = db;
  }

  internal int CreateCar(Car carData)
  {
    string sql = @"
    INSERT INTO cars (make, model, year, price, color, ownedByGrandma)
    VALUES (@Make, @Model, @Year, @Price, @Color, @OwnedByGrandma);
    SELECT LAST_INSERT_ID()
    ;";

    // NOTE ExecuteScalar will return a single value after running our sql query, in this case the id of the created item in our database
    int carId = _db.ExecuteScalar<int>(sql, carData);

    // NOTE we can fran
    // carData.Id = carId;
    // return carData;

    return carId;
  }

  internal Car GetCarById(int carId)
  {
    // NOTE this opens us up to sql injection attacks, never interpolate into our sql strings
    // string sql = $"SELECT * FROM cars WHERE id = {carId};";

    // NOTE the @ character indicates that we will pass an object to dapper with a property called carId
    string sql = "SELECT * FROM cars WHERE id = @carId;";


    // NOTE QueryFirstOrDefault will return us the first item that matches our sql query, or default to null
    // NOTE the second argument that we pass to QueryFirstOrDefault is an object that we want dapper to sanitize and inject into our sql string
    Car car = _db.QueryFirstOrDefault<Car>(sql, new { carId });

    return car;

  }

  internal List<Car> GetCars()
  {
    // NOTE create our sql string
    string sql = "SELECT * FROM cars;";

    // NOTE Query will return a collection of items that match our sql query
    // NOTE the first argument that we pass through to our Dapper query method is the sql query that we want dapper to run on our sql database
    // NOTE We have .ToList() the final result since Dapper does not return a List to us

    List<Car> cars = _db.Query<Car>(sql).ToList();

    return cars;

  }

  internal void RemoveCar(int carId)
  {
    string sql = "DELETE FROM cars WHERE id = @carId LIMIT 1;";

    // NOTE Execute will run our sql query and not return anything back
    _db.Execute(sql, new { carId });
  }

  internal Car UpdateCar(Car originalCar)
  {
    string sql = @"
    UPDATE cars 
    SET
    make = @Make,
    model = @Model,
    color = @color,
    year = @Year,
    price = @Price,
    ownedByGrandma = @OwnedByGrandma
    WHERE id = @Id
    LIMIT 1;
    SELECT * FROM cars WHERE id = @Id
    ;";

    // NOTE we run QueryFirstOrDefault here so that we update the car and then select that car so that we have proper updatedAt timestamps
    Car updatedCar = _db.QueryFirstOrDefault<Car>(sql, originalCar);

    return updatedCar;
  }
}
