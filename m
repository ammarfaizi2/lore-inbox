Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310508AbSCEHXs>; Tue, 5 Mar 2002 02:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCEHXj>; Tue, 5 Mar 2002 02:23:39 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:1796
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S293614AbSCEHXe>; Tue, 5 Mar 2002 02:23:34 -0500
Date: Tue, 5 Mar 2002 02:24:58 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: ANNOUNCEMENT: 2.4.19-pre2-ac2-xfs-shawn9 released
In-Reply-To: <Pine.LNX.4.40.0202272347320.763-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.40.0203050052390.10667-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, it's booted and im in X. please test :-)

 uname -a
Linux coredump 2.4.19-pre2-ac2-xfs-shawn9 #4 Tue Mar 5 02:10:19 EST 2002
i586 unknown

---


xfs-2.4.19-pre2-ac2-shawn9      against 2.4.18 vanilla, (March 5th, 2002)

2.4.19-pre2                     (Marcelo Tosatti)
2.4.19-pre2-ac2                 (Alan Cox)
rmap-12g                        (Rik van Riel
                                 William Lee Iriwin III)

March 4th, XFS CVS              (me)

*NOTE: xfs_utils.c finally compiles this was due to a missing #ifdef
CONFIG_PROC_FS. Other compile fixes in this release. Should build for you.

-BROKEN (March 4th, 2002)
March 3th, XFS CVS              (me)

*NOTE: As per Andre Hedrick, the IDE taskfile patch in -ac is in kludge
mode.also, the Quota patch has been merged into the XFS CVS tree and now
mostly goes in cleanly against -ac.


