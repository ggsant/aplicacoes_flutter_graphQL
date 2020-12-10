let users = [
    {
      id: "1",
      name: "Gabriela",
      email: "gabriela@example.com",
      age: 26,
    },
    {
      id: "2",
      name: "Daniela",
      email: "daniela@example.com",
      age: 27,
    },
    {
      id: "3",
      name: "João",
      email: "joao@example.com",
      age: 30,
    },
  ];
  
  let todos = [
    {
      id: "1",
      title: "Aprender GraphQL",
      description: "Estudar sobre GraphQL e como integra-lo com aplicações feitas",
      createTime: "27 March 2020, 15:30",
      deadline: "27 March 2020, 23:59",
      createdBy: "11",
    },
    {
      id: "2",
      title: "Fazer um site em flutter para o meu portifolio",
      description: "Criar um website como portifolio e hospedar no github",
      createTime: "28 March 2020, 16:45",
      deadline: "30 March 2020, 23:59",
      createdBy: "12",
    },
    {
      id: "3",
      title: "Aprender AWS",
      description: "lasbalsbasbbsalsb",
      createTime: "29 March 2020, 05:30",
      deadline: "29 March 2020, 22:00",
      createdBy: "10",
    },
    {
      id: "4",
      title: "Go to the market",
      description: "Go to the market for purchasing essentials",
      createTime: "30 March 2020, 11:10",
      deadline: "30 March 2020, 18:30",
      createdBy: "12",
    },
  ];
  
  const db = {
    users,
    todos,
  };
  
  export { db as default };