Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRCBO4d>; Fri, 2 Mar 2001 09:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbRCBO4X>; Fri, 2 Mar 2001 09:56:23 -0500
Received: from [206.245.154.69] ([206.245.154.69]:8358 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S129211AbRCBO4J>; Fri, 2 Mar 2001 09:56:09 -0500
Date: Fri, 2 Mar 2001 09:56:07 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Subject: gids in kernel
Message-ID: <Pine.LNX.4.10.10103020954140.11082-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


apache documentation states:
#  NOTE that some kernels refuse to setgid(Group) or semctl(IPC_SET)
#  when the value of (unsigned)Group is above 60000;
#  don't use Group nobody on these systems!

does this apply to linux in either the 2.2 or 2.4 kernels?
i'd like to use a block of uids from maybe 63000-65000, with
gids of the same number, for web domains, and want to know if i'll have
any problems.

Thanx,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

