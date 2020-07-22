###CODEBLOCK 2###

# Create lifespan data (40 values; n = 40)
lifespan_data <- c(1,3,4,4,4,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6,6,7,7,7,7,7,7,7,7,7,7,7,7,8,8,8,9,9,13)

# How many lifespan values?
print(paste0("How many lifespan values? ", length(lifespan_data)))

# Calculate mean lifespan (as the arithmetic mean)
print(paste0("Arithemtic mean lifespan: ", mean(lifespan_data)))

# Calculate median lifespan
print(paste0("Median lifespan: ", median(lifespan_data)))

# Maximum lifespan
print(paste0("Maximum lifespan: ", max(lifespan_data)))

# Plot
hist(lifespan_data, breaks = 15, main = "Our made-up lifespan data")
abline(v = mean(lifespan_data), col = "blue", lwd = 3.5, )
abline(v = median(lifespan_data), col = "red", lwd = 3.5)
text(5.4, 12.3, label = 'Mean', cex = 1.2)
text(7, 12.3, label = 'Median', cex = 1.2)

