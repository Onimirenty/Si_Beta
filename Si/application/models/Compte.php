<?php 
    class Compte extends CI_Model 
    {
        public  $id ;
        public  $nom ;
        public  $Debit; 
        public  $Credit; 

        

        /**
         * Get the value of id
         */
        public function getId()
        {
                return $this->id;
        }

        /**
         * Set the value of id
         */
        public function setId($id): self
        {
                $this->id = $id;

                return $this;
        }

        /**
         * Get the value of nom
         */
        public function getNom()
        {
                return $this->nom;
        }

        /**
         * Set the value of nom
         */
        public function setNom($nom): self
        {
                $this->nom = $nom;

                return $this;
        }

        /**
         * Get the value of Debit
         */
        public function getDebit()
        {
                return $this->Debit;
        }

        /**
         * Set the value of Debit
         */
        public function setDebit($Debit): self
        {
                $this->Debit = $Debit;

                return $this;
        }

        /**
         * Get the value of Credit
         */
        public function getCredit()
        {
                return $this->Credit;
        }

        /**
         * Set the value of Credit
         */
        public function setCredit($Credit): self
        {
                $this->Credit = $Credit;

                return $this;
        }
    }
?> 