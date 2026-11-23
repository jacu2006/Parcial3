using Newtonsoft.Json;

Console.WriteLine("Hello, World!");

var persona = new
{
    Nombre = "Javier Acuña",
    Edad = 20,
    Carrera = "Ingenieria en Sistemas y Computacion"
};

string json = JsonConvert.SerializeObject(persona);

Console.WriteLine(json);
