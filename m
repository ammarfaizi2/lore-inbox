Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272123AbTHDSVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272125AbTHDSVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:21:17 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:35844 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272123AbTHDSUz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:20:55 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: video4linux-list@redhat.com
Subject: [2.6-test2] bttv throws strange messages periodically
Date: Mon, 4 Aug 2003 20:20:50 +0200
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308042020.53489.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I'm using linux-2.6-test2 and the bttv subsystem throws
out strange messages every few minutes, while looking
tv with latest tvtime. My tv-card is a Hauppauge bttv 878 WinTV pci.

Please CC me on replies, as I'm not subscribed to video4linux-list.
thank you.

Aug  4 15:56:15 lfs kernel: bttv0: PLL can sleep, using XTAL (28636363).
Aug  4 15:56:15 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6f08014
Aug  4 15:56:15 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1ce8201c
Aug  4 15:56:16 lfs last message repeated 2 times
Aug  4 15:56:16 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6ba801c
Aug  4 15:56:17 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1ce8201c
Aug  4 15:56:17 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:56:20 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1ce8201c
Aug  4 15:56:20 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:56:20 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1ce8201c
Aug  4 15:56:20 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6ba801c
Aug  4 15:57:22 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a0000
Aug  4 15:57:23 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6a0101c
Aug  4 15:57:23 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a001c
Aug  4 15:57:23 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:57:23 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a001c
Aug  4 15:57:23 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:57:44 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a001c
Aug  4 15:57:44 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a001c
Aug  4 15:57:44 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:57:44 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a001c
Aug  4 15:57:44 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:57:46 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a001c
Aug  4 15:57:46 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:57:49 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1a3a001c
Aug  4 15:57:49 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 15:57:49 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6a0101c
Aug  4 15:57:52 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6a0101c
Aug  4 15:57:55 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6a01024
Aug  4 15:58:00 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xff7000
Aug  4 15:58:01 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xaa3000
Aug  4 15:58:01 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xaa301c
Aug  4 15:58:04 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xff701c
Aug  4 16:25:26 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe76401c
Aug  4 16:25:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xeb6201c
Aug  4 16:25:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe76401c
Aug  4 16:25:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xeb62000
Aug  4 16:25:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xeb62000
Aug  4 16:25:28 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:25:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe76401c
Aug  4 16:25:28 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:25:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe76401c
Aug  4 16:25:28 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:25:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xeb6201c
Aug  4 16:25:28 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:25:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe764000
Aug  4 16:25:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe76401c
Aug  4 16:25:29 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xeb61170
Aug  4 16:27:39 lfs kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug  4 16:27:40 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe9bd014
Aug  4 16:27:43 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa636014
Aug  4 16:28:32 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa636000
Aug  4 16:28:39 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa63601c
Aug  4 16:28:55 lfs kernel: bttv0: PLL can sleep, using XTAL (28636363).
Aug  4 16:28:56 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15af5000
Aug  4 16:28:56 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xd4c401c
Aug  4 16:28:56 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x11f3201c
Aug  4 16:28:56 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa24e01c
Aug  4 16:28:58 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x11f3201c
Aug  4 16:28:58 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa24e01c
Aug  4 16:28:58 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:29:01 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa24e01c
Aug  4 16:29:01 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:29:03 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x11f32000
Aug  4 16:29:05 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x11f3201c
Aug  4 16:29:05 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:29:05 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x12544000
Aug  4 16:29:05 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:29:08 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xaeea080
Aug  4 16:29:52 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15c7d01c
Aug  4 16:29:52 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15c7d01c
Aug  4 16:29:52 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:29:53 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15c7d01c
Aug  4 16:29:53 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:30:10 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9bef01c
Aug  4 16:30:10 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:30:11 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15c7d01c
Aug  4 16:30:12 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15c7d01c
Aug  4 16:30:12 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9bee000
Aug  4 16:30:12 lfs kernel: bttv0: OCERR @ 1fd9901c,bits: HSYNC OFLOW RISCI* OCERR*
Aug  4 16:30:28 lfs kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug  4 16:30:36 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x98c101c
Aug  4 16:30:43 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe86401c
Aug  4 16:30:43 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x98dc01c
Aug  4 16:30:44 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x12553014
Aug  4 16:30:55 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x98d701c
Aug  4 16:30:56 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x98dc01c
Aug  4 16:30:59 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x98d9174
Aug  4 16:31:02 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x98d7014
Aug  4 16:31:05 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x98d701c
Aug  4 16:31:26 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9f05024
Aug  4 16:31:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xc2c201c
Aug  4 16:31:31 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xc2c2000
Aug  4 16:31:32 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xc2c201c
Aug  4 16:31:33 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xc2c2014
Aug  4 16:31:35 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xbccb01c
Aug  4 16:31:35 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe878178
Aug  4 16:31:36 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xea0801c
Aug  4 16:31:38 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9ee601c
Aug  4 16:33:46 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa13b01c
Aug  4 16:33:46 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:39:19 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x11b30014
Aug  4 16:39:31 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9407000
Aug  4 16:39:45 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa3311e8
Aug  4 16:39:53 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x949701c
Aug  4 16:39:53 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:41:52 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9e1a000
Aug  4 16:44:55 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:46:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x129a701c
Aug  4 16:46:27 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:46:54 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9d6701c
Aug  4 16:46:54 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:48:26 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa76e01c
Aug  4 16:48:26 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:48:53 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:52:53 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xd9bb01c
Aug  4 16:52:53 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:52:54 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x89e401c
Aug  4 16:52:54 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:53:02 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x89e401c
Aug  4 16:53:02 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:53:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15b9601c
Aug  4 16:53:28 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:55:00 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x8b3d01c
Aug  4 16:55:00 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:55:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe93e01c
Aug  4 16:55:27 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 16:59:36 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:00:02 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x459801c
Aug  4 17:00:02 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:01:34 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1f09201c
Aug  4 17:01:35 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:02:01 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1786d01c
Aug  4 17:02:01 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:06:37 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x3aa701c
Aug  4 17:06:37 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:08:09 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1967101c
Aug  4 17:08:09 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:08:35 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xae1e01c
Aug  4 17:08:35 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:09:26 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x2fd8000
Aug  4 17:09:26 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:10:07 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x669d01c
Aug  4 17:10:07 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:11:16 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x669d01c
Aug  4 17:11:16 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:12:02 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:12:06 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x669d01c
Aug  4 17:12:06 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:12:32 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x65cf01c
Aug  4 17:12:32 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:12:40 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x65cf01c
Aug  4 17:12:40 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:12:47 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x5a2f01c
Aug  4 17:12:47 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:13:34 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x65cf01c
Aug  4 17:13:34 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:14:07 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe42201c
Aug  4 17:14:07 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:14:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x46d901c
Aug  4 17:14:28 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:14:43 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x46d901c
Aug  4 17:14:43 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:14:53 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x46d901c
Aug  4 17:14:59 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:15:10 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x46d901c
Aug  4 17:15:10 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:15:39 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x793601c
Aug  4 17:15:39 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:15:55 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:16:11 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e2de01c
Aug  4 17:16:11 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:16:14 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e2de01c
Aug  4 17:16:14 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:16:15 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e2de01c
Aug  4 17:16:15 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:16:42 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1554001c
Aug  4 17:16:42 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:16:48 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1554001c
Aug  4 17:16:48 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:08 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1554001c
Aug  4 17:17:08 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:08 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e2de01c
Aug  4 17:17:08 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:10 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e2de01c
Aug  4 17:17:10 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:17 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xb13401c
Aug  4 17:17:17 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:21 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1554001c
Aug  4 17:17:21 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:22 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1554001c
Aug  4 17:17:22 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:39 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x2e4e01c
Aug  4 17:17:39 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:17:49 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xb13401c
Aug  4 17:17:58 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x2e4e01c
Aug  4 17:18:10 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xb13401c
Aug  4 17:18:10 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:21 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x2e4e01c
Aug  4 17:18:21 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x2e4e01c
Aug  4 17:18:27 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x2e4e01c
Aug  4 17:18:27 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:30 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x192001c
Aug  4 17:18:30 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:32 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x3d5801c
Aug  4 17:18:32 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:32 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x192001c
Aug  4 17:18:32 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:40 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x192001c
Aug  4 17:18:40 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:18:58 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x3d5801c
Aug  4 17:18:58 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:19:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e9a801c
Aug  4 17:19:27 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:19:32 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e9a801c
Aug  4 17:19:32 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:21:17 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x739201c
Aug  4 17:21:17 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:21:44 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e9a801c
Aug  4 17:21:44 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:23:16 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x739201c
Aug  4 17:23:16 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:23:43 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6f0401c
Aug  4 17:23:43 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:24:53 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1f74801c
Aug  4 17:24:53 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:24:53 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:31:36 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15d8c01c
Aug  4 17:31:36 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:33:08 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x12d3e01c
Aug  4 17:33:08 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:33:34 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15fa401c
Aug  4 17:33:34 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:35:06 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1543601c
Aug  4 17:35:06 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:39:42 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x3ae601c
Aug  4 17:39:42 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:40:08 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x8ef101c
Aug  4 17:40:08 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:41:40 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1390b01c
Aug  4 17:41:41 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:45:48 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x7d4401c
Aug  4 17:45:48 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:45:49 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x16d2c01c
Aug  4 17:45:49 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:45:49 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1d00a01c
Aug  4 17:45:49 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:46:16 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x845b01c
Aug  4 17:46:16 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:46:43 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1cdd901c
Aug  4 17:46:43 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:50:12 lfs kernel: bttv0: PLL can sleep, using XTAL (28636363).
Aug  4 17:50:23 lfs kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Aug  4 17:52:50 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x181ad01c
Aug  4 17:52:50 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:53:17 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x6a5a01c
Aug  4 17:53:17 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:54:49 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xdd7d01c
Aug  4 17:54:49 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:54:56 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1d70b01c
Aug  4 17:54:56 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:55:16 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:59:24 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1899d01c
Aug  4 17:59:24 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 17:59:51 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x57cf01c
Aug  4 17:59:51 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:01:23 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x662d01c
Aug  4 18:01:23 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:01:50 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x662d000
Aug  4 18:01:50 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:05:58 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1608d01c
Aug  4 18:05:58 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:06:25 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15f7801c
Aug  4 18:06:25 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:07:57 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e7f101c
Aug  4 18:07:57 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:08:24 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x726201c
Aug  4 18:08:24 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:12:33 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x16c8a01c
Aug  4 18:12:33 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:12:59 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x147dc01c
Aug  4 18:12:59 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:14:31 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x12d8d01c
Aug  4 18:14:31 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:14:58 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1eeec01c
Aug  4 18:14:58 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:19:07 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x162d301c
Aug  4 18:19:07 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:19:33 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1f7cd01c
Aug  4 18:19:34 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:21:06 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1dec201c
Aug  4 18:21:06 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:21:32 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xc22701c
Aug  4 18:21:32 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:22:37 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x906f01c
Aug  4 18:22:37 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:25:41 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15e6401c
Aug  4 18:25:41 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:26:08 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1f74001c
Aug  4 18:26:08 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:27:40 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x77c101c
Aug  4 18:27:40 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:28:06 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x9f2001c
Aug  4 18:28:06 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:32:42 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xb0ac01c
Aug  4 18:32:42 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:34:14 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1888301c
Aug  4 18:34:14 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:34:41 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xbf0d01c
Aug  4 18:34:41 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:36:13 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x12a1401c
Aug  4 18:36:13 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:40:48 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x631c01c
Aug  4 18:41:15 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15b4b01c
Aug  4 18:41:15 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:42:47 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1c9ba01c
Aug  4 18:42:47 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:43:14 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:47:22 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1938901c
Aug  4 18:47:22 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:47:49 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x15f0001c
Aug  4 18:47:49 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:49:21 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x3e6401c
Aug  4 18:49:21 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:49:48 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x77f501c
Aug  4 18:49:48 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:53:56 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:54:23 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e4e101c
Aug  4 18:54:23 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:55:55 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x976d01c
Aug  4 18:55:55 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:56:22 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x959701c
Aug  4 18:56:22 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 18:57:54 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:02:29 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e4e101c
Aug  4 19:02:29 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:02:56 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x77f501c
Aug  4 19:02:56 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:04:28 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x788201c
Aug  4 19:04:28 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:04:55 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x271b000
Aug  4 19:04:55 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:09:04 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1e4e101c
Aug  4 19:09:04 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:09:30 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1c03a01c
Aug  4 19:09:30 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:11:02 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x7fdd01c
Aug  4 19:11:02 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:11:29 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa41701c
Aug  4 19:11:29 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:15:38 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:16:04 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x140cb01c
Aug  4 19:16:04 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:17:36 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x89b401c
Aug  4 19:17:36 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:18:03 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x140cb01c
Aug  4 19:18:03 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:22:39 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe7ba01c
Aug  4 19:22:39 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:24:11 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x89b401c
Aug  4 19:24:11 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:24:37 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xb1ed01c
Aug  4 19:24:37 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:26:09 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xb1ed01c
Aug  4 19:26:09 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:30:45 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xb1ed01c
Aug  4 19:30:45 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:31:12 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x89b401c
Aug  4 19:31:12 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:32:44 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x89b401c
Aug  4 19:32:44 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:33:10 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe7ba01c
Aug  4 19:33:10 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:37:19 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa41601c
Aug  4 19:37:19 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:37:46 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1ddd701c
Aug  4 19:37:46 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:39:18 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa39101c
Aug  4 19:39:18 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:39:44 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa5e901c
Aug  4 19:39:44 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:41:43 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xa39101c
Aug  4 19:41:43 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:43:39 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x14b85178
Aug  4 19:44:34 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:45:01 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xbc3001c
Aug  4 19:45:01 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:46:41 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe990014
Aug  4 19:47:42 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe990014
Aug  4 19:47:55 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe99001c
Aug  4 19:48:06 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xbadd014
Aug  4 19:48:07 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xbadd000
Aug  4 19:52:26 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe99001c
Aug  4 19:52:26 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:52:53 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x77c401c
Aug  4 19:52:53 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:54:25 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x77c401c
Aug  4 19:54:25 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:54:52 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe99001c
Aug  4 19:54:52 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:55:53 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x77c401c
Aug  4 19:55:53 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:59:00 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe99001c
Aug  4 19:59:00 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 19:59:27 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1391001c
Aug  4 19:59:27 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:00:59 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe99001c
Aug  4 20:00:59 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:01:26 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1391001c
Aug  4 20:01:26 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:05:34 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:06:01 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1391001c
Aug  4 20:06:01 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:07:33 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1391001c
Aug  4 20:07:33 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:08:00 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0xe99001c
Aug  4 20:08:00 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:12:35 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x1decf01c
Aug  4 20:12:35 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:14:07 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x8b1701c
Aug  4 20:14:07 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*
Aug  4 20:14:34 lfs kernel: bttv0: Huh? IRQ latency? main=0x1fd99000 rc=0x797c01c
Aug  4 20:14:34 lfs kernel: bttv0: OCERR @ 1fd99000,bits: HSYNC OFLOW OCERR*


- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
Penguin on this machine:  Linux 2.6.0-test2  - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/LqQCoxoigfggmSgRAjZXAJ9rFNLGmNvWB/bJovxtTnVR5OlegwCffyJg
c++xWMYyfKEJIrRd+jdOIhs=
=6GLQ
-----END PGP SIGNATURE-----

