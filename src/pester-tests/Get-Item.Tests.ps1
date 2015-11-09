﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path

Describe "Get-Item" {
    It "Should list all the items in the current working directory when asterisk is used" {
        (Get-Item $here/*).GetType().BaseType | Should Be 'array'
        (Get-Item $here/*).GetType().Name | Should Be 'Object[]'
    }

    It "Should return the name of the current working directory when a dot is used" {
        (Get-Item $here).GetType().BaseType | Should Be 'System.IO.FileSystemInfo'
        (Get-Item $here).Name | Should Be 'pester-tests'
    }

    It "Should return the proper Name and BaseType for directory objects vs file system objects" {
        (Get-Item $here).GetType().Name | Should Be 'DirectoryInfo'
        (Get-Item $here/Get-Item.Tests.ps1).GetType().Name | Should Be 'FileInfo'
    }

    It "Should have mode flags set" {
        ls $here | foreach-object { $_.Mode | Should Not BeNullOrEmpty }
    }
}