Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280950AbRKORW4>; Thu, 15 Nov 2001 12:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280951AbRKORWq>; Thu, 15 Nov 2001 12:22:46 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:13186 "HELO
	mail.temp123.org") by vger.kernel.org with SMTP id <S280950AbRKORW1>;
	Thu, 15 Nov 2001 12:22:27 -0500
Date: Thu, 15 Nov 2001 12:22:21 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maestro 2E vs. Power mgmt
Message-ID: <20011115122221.A11236@temp123.org>
In-Reply-To: <20011115120314.A11264@temp123.org> <E164QH3-0000xW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E164QH3-0000xW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 15, 2001 at 05:26:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 05:26:01PM +0000, Alan Cox wrote:
> Nothing immediately strikes me - could be its not got CLKRUN wired up
> properly. What pci bridges does it have ?

frabjous:~# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
00:04.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 12)
00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:07.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
00:09.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
00:0c.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
frabjous:~# 

-- 
Josh Litherland (fauxpas@temp123.org)
