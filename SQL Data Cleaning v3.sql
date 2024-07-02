FROM [PortfolioProject].[dbo].[NashvilleHousing]

select * from PortfolioProject.dbo.NashvilleHousing

select SaleDate from PortfolioProject.dbo.NashvilleHousing

select SaleDate, CONVERT(Date,SaleDate)
from PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

select SaleDateConverted from NashvilleHousing 

select PropertyAddress from NashvilleHousing 
where PropertyAddress is null

select * from NashvilleHousing 
--where PropertyAddress is null
order by ParcelID


select a.parcelID, a.PropertyAddress, b.parcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress) from NashvilleHousing a
JOIN NashvilleHousing b
on a.parcelID = b.parcelID
AND a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null

Update a
SET PropertyAddress = isnull (a.PropertyAddress,b.PropertyAddress) from NashvilleHousing a
JOIN NashvilleHousing b
on a.parcelID = b.parcelID
AND a.[UniqueID] <> b.[UniqueID]
where a.PropertyAddress is null

select PropertyAddress
From NashvilleHousing a

select SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
, SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
from NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddressNew Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddressNew = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

select * from NashvilleHousing

select OwnerAddress from NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


select DISTINCT(SoldAsVacant)
from NashvilleHousing

select DISTINCT(SoldAsVacant), Count(SoldAsVacant)
from NashvilleHousing
Group by SoldAsVacant
Order by 2

select SoldAsVacant,
CASE when SoldAsVacant = 'Y' THEN 'YES'
when SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
from NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = 	CASE when SoldAsVacant = 'Y' THEN 'YES'
when SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END

WITH RowNumCTE AS(
select *,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				 UniqueID)
				 row_num

from NashvilleHousing
	)

select * from RowNumCTE
where row_num > 1
order by PropertyAddress
	--order by PropertyAddress

ALTER TABLE NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress

