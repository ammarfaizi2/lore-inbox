Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261926AbRESR75>; Sat, 19 May 2001 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261929AbRESR7r>; Sat, 19 May 2001 13:59:47 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:56588 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S261926AbRESR7d>; Sat, 19 May 2001 13:59:33 -0400
Message-ID: <3B06B453.6C921457@damncats.org>
Date: Sat, 19 May 2001 13:58:43 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Potential help for VIA problems and ASUS motherboards
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've seen a lot of messages regarding problems with the VIA chipset...
I've experienced them myself.

Anyways, I just put in a new ASUS CUV4X-D motherboard, BIOS revision
1004. Once installed, I ran into a raft of problems when IO-APIC was
enabled... and discovered that ASUS had a BIOS update (revision 1007)
available. Once the BIOS was updated and MPS 1.4 support was disabled,
everything has been working fine, including USB with IO-APIC enabled. I
also don't seem to be getting the timer problem anymore.

Anyways, if you have one of these boards, you may want to flash your
BIOS and see if the problems are fixed. YMMV, but it worked for me.

John
