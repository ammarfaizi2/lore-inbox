Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSD1O6Q>; Sun, 28 Apr 2002 10:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSD1O6P>; Sun, 28 Apr 2002 10:58:15 -0400
Received: from nextgeneration.speedroad.net ([195.139.232.50]:44430 "HELO
	nextgeneration.speedroad.net") by vger.kernel.org with SMTP
	id <S310835AbSD1O6P>; Sun, 28 Apr 2002 10:58:15 -0400
Date: Sun, 28 Apr 2002 16:58:13 +0200
From: Arnvid Karstad <arnvid@karstad.org>
To: linux-kernel@vger.kernel.org
Subject: Problems with HTP 370 and Linux 2.4.18?
Organization: Int
Message-Id: <20020428164005.01F4.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya, 

I tried to install Linux on one of my desktop's and got into a small
icky situation..

The harddrives on this machine are all attached to the HPT370 ata-100
controller.. The internal controller has an cd-r only.

After installing and rebooting with ata100 kernel was shipped with
slackware 8 it worked fine, but after I tried to upgrade the kernel to
2.4.18 it seems not to enjoy my configuration

I'm getting these alot.:
EXT2-fs error (device ide2(33,3)): ext2_write_inode: unable to read inode block - inode=65549, block=131077

and when I do the only cure is to power cycle :(

The Motherboard is an Abit VP6 with VIA chipset... and dual cpu's.

I tested the configuration in win2k and the drive seems fine there.
Reinstalled linux again and voila.. a few of these again :(

Is there some magical kernel parameter that can be set to help out here?
;-) since and older kernel did work.. or is there any patches worth
testing? ;)


Mvh/Best regards,

Arnvid L. Karstad


