Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291174AbSBQWZm>; Sun, 17 Feb 2002 17:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291177AbSBQWZc>; Sun, 17 Feb 2002 17:25:32 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:3844
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S291174AbSBQWZ0>; Sun, 17 Feb 2002 17:25:26 -0500
Date: Sun, 17 Feb 2002 17:26:34 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: ANNOUNCEMENT: 2.4.18-rc1-xfs-shawn6 released
In-Reply-To: <Pine.LNX.4.40.0202170333030.28167-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.40.0202171726130.277-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xfs-2.4.18-rc1-shawn6   against 2.4.17 vanilla. (Feb 17th, 2002)

Contains:

2.4.18-rc1                      (Marcelo Tosatti)
rmap12f                         (Rik van Riel
                                 William Lee Irwin III)
Newest XFS from CVS-HEAD        (me)
IDE taskfile IO patch           (Andre Hedrick)

* NOTES:

Removed -pre9-ac4 because Quotas seem to break hard with XFS/EXT2/3.
- This hurts the merge of XFS into -mjc until we sort this out.

Shawn.

