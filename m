Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314385AbSEIVhb>; Thu, 9 May 2002 17:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSEIVh3>; Thu, 9 May 2002 17:37:29 -0400
Received: from [194.252.160.219] ([194.252.160.219]:36246 "EHLO st0.invers.fi")
	by vger.kernel.org with ESMTP id <S314385AbSEIVh1>;
	Thu, 9 May 2002 17:37:27 -0400
Date: Fri, 10 May 2002 00:36:56 +0300 (EEST)
From: tchiwam <tchiwam@ees2.oulu.fi>
X-X-Sender: tchiwam@st0
To: linux-kernel@vger.kernel.org
Subject: Silent death , PPC-linux 2.4.18-rc4 -> .19-rc7
Message-ID: <Pine.LNX.4.44.0205100025180.31628-100000@st0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Symptomes: Dies silently and it is unpredictable , sometimes Hardisk leds
stays on , sometime not. Can be weeks between crashes or just few minutes.

I used a lot of the 2.4.17 for many months without any crashes.

 only way to fix it is to restart the machine with reset.

I have read something about a new aic7xxx driver, but somehow haven't
found the driver anywhere.

The machine is a Apple 9500 with
PowerPC G3 (upgrade)
512MB Ram

Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 116).
MACE ethernet
  Masquarading between both interfaces public to private network

SCSI storage controller: Adaptec 7892A (rev 2).
SCSI storage controller: Adaptec AHA-2940U2/W (rev 1).
  There is 4 hard disks 2 on each host controller, They are Linux Raid 1+0
  And the swap is also mirrored on them 2x raid 1 (512MB)
  This machine serves nfs to the private network.


Thank you,
Philippe

