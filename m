Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbRA0IeV>; Sat, 27 Jan 2001 03:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132091AbRA0IeK>; Sat, 27 Jan 2001 03:34:10 -0500
Received: from c1123685-a.crvlls1.or.home.com ([24.12.161.234]:9733 "EHLO
	inbetween.blorf.net") by vger.kernel.org with ESMTP
	id <S132057AbRA0IeJ>; Sat, 27 Jan 2001 03:34:09 -0500
Date: Sat, 27 Jan 2001 00:38:48 -0800 (PST)
From: Jacob Luna Lundberg <kernel@gnifty.net>
Reply-To: jacob@chaos2.org
To: linux-kernel@vger.kernel.org
Subject: hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete
 Error }
Message-ID: <Pine.LNX.4.21.0101252046320.13852-100000@inbetween.blorf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been getting this during the boot sequence for quite some time now.
They don't seem to impact the functionality of the drive any though.  Just
another extra-verbose kernel message I should ignore?  :)

(This is from the 2.4.1-pre10 btw.)

hdd: CD-ROM TW 120D, ATAPI CD/DVD-ROM drive
hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdd: set_drive_speed_status: error=0x04
[...]
hdd: ATAPI 12X CD-ROM drive, 240kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12

-Jacob


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
