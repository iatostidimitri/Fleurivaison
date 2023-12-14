<?php
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Ajouter un article</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>

<body>
    <div class="row g-3 justify-content-center">
        <div class="col-sm-8">
            <h1>Ajouter un article</h1>

            <form action="article.php" method="post">
                <label for="nom_article" class="form-label">Couronne de fleurs</label>
                <input type="text" name="nom_article" size="50" class="form-control" required />
                <label for="contenu_article" class="form-label">Lorem ipsum dolor sit, amet consectetur adipisicing elit. Similique saepe ut tenetur repellat iste consequuntur omnis delectus nobis quisquam. Alias, cupiditate laborum! Distinctio corporis iusto fuga, nisi magni obcaecati iure.</label>
                <input type="text" name="contenu_article" size="300" class="form-control" />
                <button class="w-50 btn btn-primary btn-lg" type="submit">Ajouter</button>
            </form>
			
        </div>
    </div>
    <?php

    if (isset($_POST['nom_article']) && isset($_POST['contenu_article'])) {
        $errors = [];
        $name = '';
        $content = '';

        if (empty($_POST['nom_article'])) {
            $errors[] = 'Le nom de l\'article ne peut être vide';
        }
        if (empty($errors)) {
            $servername = "docker-lamp-mysql";
            $username = "root";
            $password = "p@ssw0rd";
            $dbname = 'articles';
            $conn = null;

            $name = $_POST['nom_article'];
            $content = $_POST['contenu_article'];
        }
            try {
                $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
                $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);


                $sth = $conn->prepare("INSERT INTO article (nom_article,contenu_article) VALUES (:article_name,:article_content)");
                $sth->bindParam('article_name', $name, PDO::PARAM_STR);
                $sth->bindParam('article_content', $content, PDO::PARAM_STR);
            }
    }
    try{
        $req=$db->prepare("SELECT * FROM article WHERE id_article,nom_article,contenu_article");

        $req->execute();
        while ($donnees =$req->fetch()){
            echo '<p>'.$donnees['id_article'].'</p>';
            echo '<p>'.$donnees['nom_article'].'</p>';
            echo '<p>'.$donnees['contenu_article'].'</p>';
        } 
}catch (Exception $e){
    
    die('Erreur :'.$e->getMessage());
}


    ?>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
</body>

</html>