Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130143AbRBZEyp>; Sun, 25 Feb 2001 23:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbRBZEyf>; Sun, 25 Feb 2001 23:54:35 -0500
Received: from jeeves.wrkhors.com ([207.227.243.17]:52239 "EHLO
	getz.wrkhors.com") by vger.kernel.org with ESMTP id <S130143AbRBZEyQ>;
	Sun, 25 Feb 2001 23:54:16 -0500
Message-ID: <3A99E106.D2FA2018@wrkhors.com>
Date: Sun, 25 Feb 2001 22:52:22 -0600
From: Steven Lembark <lembark@wrkhors.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: perhaps an oddity in 2.4.1?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


straight 2.4.1.  accidentally did:

	mount /dev/blah /mnt;

ok., looks like what i need.

	mount /dev/blah /opt/src;

ok., seems mounted.
er...  just realized i forgot to umount /mnt the first time.

i don't remember multiple mounts as a declared feature in 
2.4.1 [wouldn't be the first time i forgot].  might even
be handy.  is there any doc to describe multiple mounts
or is this accidental?

thanx.

-- 
 Steven Lembark                                   2930 W. Palmer St.
                                                 Chicago, IL  60647
 lembark@wrkhors.com                                   800-762-1582
