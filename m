Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVFTItg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFTItg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 04:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFTItg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 04:49:36 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:15070 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261179AbVFTIta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 04:49:30 -0400
Message-ID: <42B6831B.3040506@ens-lyon.org>
Date: Mon, 20 Jun 2005 10:49:31 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6746B.4020305@ens-lyon.org> <20050620081443.GA31831@isilmar.linta.de>
In-Reply-To: <20050620081443.GA31831@isilmar.linta.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090806050300030307050207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090806050300030307050207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Le 20.06.2005 10:14, Dominik Brodowski a écrit :
> Hi,
> 
> On Mon, Jun 20, 2005 at 09:46:51AM +0200, Brice Goglin wrote:
> 
>>pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
>>cs: IO port probe 0x2000-0x2fff: <- stopped here
> 
> 
> Could you send me the /proc/ioports from 2.6.12, please? Did some other -mm
> kernel work during the past weeks?

/proc/ioports is attached.
Yes all other -mm kernel worked during the past weeks.

Thanks,
Brice

--------------090806050300030307050207
Content-Type: text/plain;
 name="ioports-2.6.12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioports-2.6.12"

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-0107 : smsc-ircc2
0140-014f : pnp 00:0b
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : smsc-ircc2
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0c
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
  1008-100b : PM_TMR
  1020-1020 : PM2_CNT_BLK
  1028-102b : GPE0_BLK
  102c-102f : GPE1_BLK
1080-1085 : ACPI CPU throttle
1100-113f : 0000:00:1f.0
  1100-113f : motherboard
    1100-113f : pnp 00:0c
1200-121f : motherboard
  1200-121f : pnp 00:0c
2000-20ff : 0000:02:04.0
2400-24ff : 0000:02:09.0
  2400-24ff : Allegro
2800-283f : 0000:02:08.0
  2800-283f : e100
2840-2847 : 0000:02:04.0
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
    3000-30ff : radeonfb
4000-401f : 0000:00:1d.0
  4000-401f : uhci_hcd
4020-403f : 0000:00:1d.1
  4020-403f : uhci_hcd
4040-405f : 0000:00:1d.2
  4040-405f : uhci_hcd
4060-406f : 0000:00:1f.1
  4060-4067 : ide0
  4068-406f : ide1
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #03
4c00-4cff : PCI CardBus #07
5000-50ff : PCI CardBus #07

--------------090806050300030307050207--
