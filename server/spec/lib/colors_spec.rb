describe Colors do
  describe "blend" do
      it "blends to 0" do
        expect(
          Colors.blend(0xFFFFFF, 0x000000, 0).to_hex_s
        ).to eq(0xFFFFFF.to_hex_s)

        expect(
          Colors.blend(0x000000, 0xFFFFFF, 0).to_hex_s
        ).to eq(0x000000.to_hex_s)
      end

    it "blends to 0.5" do
      expect(
        Colors.blend(0xFFFFFF, 0x000000, 0.5).to_hex_s
      ).to eq(0x7F7F7F.to_hex_s)

      expect(
        Colors.blend(0x000000, 0xFFFFFF, 0.5).to_hex_s
      ).to eq(0x7F7F7F.to_hex_s)
    end

    it "blends to 100%" do
      expect(
        Colors.blend(0xFFFFFF, 0x000000, 1).to_hex_s
      ).to eq(0x000000.to_hex_s)

      expect(
        Colors.blend(0x000000, 0xFFFFFF, 1).to_hex_s
      ).to eq(0xFFFFFF.to_hex_s)
    end

    it "works in the expected direction" do
      expect(
        Colors.blend(0x101010, 0x000000, 0.2).to_hex_s
      ).to eq(0x0C0C0C.to_hex_s)

      expect(
        Colors.blend(0x000000, 0x101010, 0.2).to_hex_s
      ).to eq(0x030303.to_hex_s)

      expect(
        Colors.blend(0x101010, 0x000000, 0.8).to_hex_s
      ).to eq(0x030303.to_hex_s)

      expect(
        Colors.blend(0x000000, 0x101010, 0.8).to_hex_s
      ).to eq(0x0C0C0C.to_hex_s)
    end
  end
end
