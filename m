Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286576AbRLUJIC>; Fri, 21 Dec 2001 04:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286660AbRLUJHv>; Fri, 21 Dec 2001 04:07:51 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:41169 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S286656AbRLUJHl>; Fri, 21 Dec 2001 04:07:41 -0500
Date: Fri, 21 Dec 2001 01:08:08 -0800
From: Iain McClatchie <iain@TrueCircuits.com>
Subject: Promise Ultra ATA 133 TX2 support for the 2.2 kernel series
To: linux-kernel@vger.kernel.org, andre@linux-ide.org
Message-id: <3C22FBF8.62C7B4E3@TrueCircuits.com>
Organization: True Circuits
MIME-version: 1.0
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

Is there any chance you will backport the Promise ATA/133
patch to the 2.2 kernel series?  If not, is anyone you
know of working on a backport?

I've got a pair of 160GB Maxtors I'd like to get working
soon, perhaps without rolling the office forward to the 2.4
kernel... :)  I guess my alternative to finding a 2.2 patch
somewhere is just using the first 137 GB of the drives, and
extending the partition and ext2 filesystem later when we
finally upgrade our kernels.

-Iain McClatchie                       iain@truecircuits.com
Chief Architect                        650-691-7604 voice
True Circuits, Inc.                    650-691-7606 FAX
                                       650-703-2095 cell
