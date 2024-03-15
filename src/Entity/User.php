<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: UserRepository::class)]
class User
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 125, nullable: true)]
    private ?string $name = null;

    #[ORM\Column(length: 125, nullable: true)]
    private ?string $n = null;

    #[ORM\Column(length: 125, nullable: true)]
    private ?string $newcoltest = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(?string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getN(): ?string
    {
        return $this->n;
    }

    public function setN(?string $n): self
    {
        $this->n = $n;

        return $this;
    }

    public function getNewcoltest(): ?string
    {
        return $this->newcoltest;
    }

    public function setNewcoltest(?string $newcoltest): self
    {
        $this->newcoltest = $newcoltest;

        return $this;
    }
}
