Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290595AbSBRTCu>; Mon, 18 Feb 2002 14:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbSBRTC0>; Mon, 18 Feb 2002 14:02:26 -0500
Received: from harddata.com ([216.123.194.198]:2318 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S290609AbSBRSvq>;
	Mon, 18 Feb 2002 13:51:46 -0500
Date: Mon, 18 Feb 2002 11:51:43 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre9-ac4 fails to boot
Message-ID: <20020218115143.A13070@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note that I tried to boot 2.4.18-pre9-ac4 (plus Alpha specific
adjustments) on Alpha-Nautilus box.  Got stuck in that with:

..........
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
Kernel panic: VFS: Unable to mount root fs on 03:00

I have no problems booting 2.4.18-rc1 (with the same adjustments :-).
Anybody knows by any chance what this is about before I will start
digging?

  Michal

PS. "Adjustments" mentioned above are required or I will not boot at all
with any current kernel but this is still WIP.
