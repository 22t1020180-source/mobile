import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Bai2WrapperScreen extends StatefulWidget {
  const Bai2WrapperScreen({super.key});

  @override
  State<Bai2WrapperScreen> createState() => _Bai2WrapperScreenState();
}

class _Bai2WrapperScreenState extends State<Bai2WrapperScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedIndex == 0
            ? Colors.white
            : const Color(0xFF1d293d),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
            color: _selectedIndex == 0 ? Colors.black : Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _selectedIndex == 0
                ? Colors.grey.shade200
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleButton(
                index: 0,
                label: 'Welcome',
                isSelected: _selectedIndex == 0,
              ),
              _buildToggleButton(
                index: 1,
                label: 'Home Work',
                isSelected: _selectedIndex == 1,
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.heart,
              color: _selectedIndex == 0 ? Colors.black : Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Iconsax.setting_2,
              color: _selectedIndex == 0 ? Colors.black : Colors.white,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [_WelcomeCharlieContent(), _HomeWorkContent()],
      ),
    );
  }

  Widget _buildToggleButton({
    required int index,
    required String label,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (_selectedIndex == 0 ? Colors.white : const Color(0xFF1d293d))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? (_selectedIndex == 0 ? Colors.black : Colors.white)
                : (_selectedIndex == 0 ? Colors.black54 : Colors.white70),
          ),
        ),
      ),
    );
  }
}

// Welcome Charlie Content (without AppBar)
class _WelcomeCharlieContent extends StatelessWidget {
  const _WelcomeCharlieContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header Title
            const Text(
              'Welcome,\nCharlie',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: Color(0xFF2D3436),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 30),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  prefixIcon: Icon(Iconsax.search_normal, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Saved Places Header
            const Text(
              'Saved Places',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3436),
              ),
            ),

            const SizedBox(height: 20),

            // Grid of Places
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: [
                  _buildPlaceCard(imagePath: 'assets/images/noel_1.png'),
                  _buildPlaceCard(imagePath: 'assets/images/noel_2.png'),
                  _buildPlaceCard(imagePath: 'assets/images/noel_3.png'),
                  _buildPlaceCard(imagePath: 'assets/images/noel_4.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard({required String imagePath}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          onError: (_, __) {},
        ),
      ),
    );
  }
}

// Home Work Content (without AppBar)
class _HomeWorkContent extends StatelessWidget {
  const _HomeWorkContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Search Header
          _buildSearchHeader(),
          // Filter Buttons
          _buildFilterButtons(),
          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '757 chỗ nghỉ',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
          ),
          // Hotel List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel1/400/300',
                  name: 'aNhill Boutique',
                  rating: 5,
                  score: 9.5,
                  scoreLabel: 'Xuất sắc',
                  reviews: 95,
                  location: 'Huế',
                  distance: '0,6km',
                  roomType: '1 suite riêng tư: 1 giường',
                  price: 109,
                  hasBreakfast: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel2/400/300',
                  name: 'An Nam Hue Boutique',
                  rating: 4,
                  score: 9.2,
                  scoreLabel: 'Tuyệt hảo',
                  reviews: 34,
                  location: 'Cư Chính',
                  distance: '0,9km',
                  roomType: '1 phòng khách sạn: 1 giường',
                  price: 20,
                  hasBreakfast: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel3/400/300',
                  name: 'Huế Jade Hill Villa',
                  rating: 0,
                  score: 8.0,
                  scoreLabel: 'Rất tốt',
                  reviews: 1,
                  location: 'Cư Chính',
                  distance: '1,3km',
                  roomType: '1 biệt thự nguyên căn – 1.000 m²',
                  roomDetails:
                      '4 giường • 3 phòng ngủ • 1 phòng khách • 3 phòng tắm',
                  price: 285,
                  hasBreakfast: false,
                  isLastRoom: true,
                  noPaymentNeeded: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel4/400/300',
                  name: 'Êm Villa',
                  rating: 4,
                  score: 8.8,
                  scoreLabel: 'Tuyệt vời',
                  reviews: 23,
                  location: 'Huế',
                  distance: '1,5km',
                  roomType: '1 biệt thự: 2 giường',
                  price: 150,
                  hasBreakfast: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel5/400/300',
                  name: 'Pilgrimage Village',
                  rating: 5,
                  score: 9.1,
                  scoreLabel: 'Tuyệt hảo',
                  reviews: 156,
                  location: 'Huế',
                  distance: '2,1km',
                  roomType: '1 phòng đôi deluxe: 1 giường đôi',
                  price: 89,
                  hasBreakfast: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel6/400/300',
                  name: 'La Residence Hue',
                  rating: 5,
                  score: 9.4,
                  scoreLabel: 'Xuất sắc',
                  reviews: 287,
                  location: 'Huế',
                  distance: '0,3km',
                  roomType: '1 phòng Superior: 1 giường king',
                  price: 195,
                  hasBreakfast: true,
                  noPaymentNeeded: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel7/400/300',
                  name: 'Alba Wellness Resort',
                  rating: 5,
                  score: 8.9,
                  scoreLabel: 'Tuyệt vời',
                  reviews: 78,
                  location: 'Phong Điền',
                  distance: '15km',
                  roomType: '1 phòng bungalow: 2 giường',
                  roomDetails: 'View núi • Hồ bơi riêng',
                  price: 320,
                  hasBreakfast: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel8/400/300',
                  name: 'Vedana Lagoon Resort',
                  rating: 5,
                  score: 9.0,
                  scoreLabel: 'Tuyệt hảo',
                  reviews: 112,
                  location: 'Phú Lộc',
                  distance: '18km',
                  roomType: '1 villa trên nước: 1 giường king',
                  roomDetails: 'View đầm phá • Spa miễn phí',
                  price: 450,
                  hasBreakfast: true,
                  isLastRoom: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel9/400/300',
                  name: 'Moonlight Hotel Hue',
                  rating: 4,
                  score: 8.5,
                  scoreLabel: 'Rất tốt',
                  reviews: 245,
                  location: 'Huế',
                  distance: '0,8km',
                  roomType: '1 phòng tiêu chuẩn: 2 giường đơn',
                  price: 35,
                  hasBreakfast: false,
                  noPaymentNeeded: true,
                ),
                _buildHotelCard(
                  imageUrl: 'https://picsum.photos/seed/hotel10/400/300',
                  name: 'Banyan Tree Lang Co',
                  rating: 5,
                  score: 9.6,
                  scoreLabel: 'Xuất sắc',
                  reviews: 423,
                  location: 'Lăng Cô',
                  distance: '45km',
                  roomType: '1 pool villa: 1 giường king',
                  roomDetails: 'Beach front • Hồ bơi riêng • Butler service',
                  price: 850,
                  hasBreakfast: true,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      color: const Color(0xFF1d293d),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange, width: 2),
        ),
        child: Row(
          children: [
            const Icon(Iconsax.location, color: Colors.black54, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Xung quanh vị trí hiện tại',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Text(
              '23 thg 10 – 24 thg 10',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterButton(
            Iconsax.arrow_swap_horizontal,
            'Sắp xếp',
            hasIndicator: true,
          ),
          _buildFilterButton(Iconsax.filter, 'Lọc'),
          _buildFilterButton(Iconsax.map, 'Bản đồ'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    IconData icon,
    String label, {
    bool hasIndicator = false,
  }) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black87, size: 20),
      label: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasIndicator)
            Container(
              margin: const EdgeInsets.only(left: 6),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF1d293d),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHotelCard({
    required String imageUrl,
    required String name,
    required int rating,
    required double score,
    required String scoreLabel,
    required int reviews,
    required String location,
    required String distance,
    required String roomType,
    String? roomDetails,
    required int price,
    bool hasBreakfast = false,
    bool isLastRoom = false,
    bool noPaymentNeeded = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left - Image with Badge
            SizedBox(
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  if (hasBreakfast)
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFF0D6E3F),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Bao bữa sáng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Right - Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Stars & Heart
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1d293d),
                              ),
                            ),
                            if (rating > 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Row(
                                  children: List.generate(
                                    rating,
                                    (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Icon(Iconsax.heart, color: Colors.grey[350], size: 22),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Score Row
                  if (score > 0)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1d293d),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            score.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          scoreLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' • $reviews đánh giá',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 4),
                  // Location
                  Row(
                    children: [
                      Icon(Iconsax.location, size: 12, color: Colors.grey[600]),
                      const SizedBox(width: 3),
                      Text(
                        '$location • Cách bạn $distance',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Room Type
                  Text(
                    roomType,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (roomDetails != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        roomDetails,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ),
                  const SizedBox(height: 8),
                  // Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'US\$$price',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Đã bao gồm thuế và phí',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (isLastRoom)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                'Chỉ còn 1 căn với giá này trên Booking.com',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          if (noPaymentNeeded)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Iconsax.tick_circle,
                                    size: 12,
                                    color: Colors.green[700],
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    'Không cần thanh toán trước',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
