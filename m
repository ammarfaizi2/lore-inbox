Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315231AbSEFWZa>; Mon, 6 May 2002 18:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315233AbSEFWZ3>; Mon, 6 May 2002 18:25:29 -0400
Received: from pl174.dhcp.adsl.tpnet.pl ([217.98.31.174]:4736 "EHLO
	bzzzt.slackware.pl") by vger.kernel.org with ESMTP
	id <S315231AbSEFWZ2>; Mon, 6 May 2002 18:25:28 -0400
Date: Tue, 7 May 2002 00:27:17 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
X-X-Sender: <pkot@bzzzt.slackware.pl>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>
Subject: [ANN] NTFS 2.0.6a for Linux 2.4.18
Message-ID: <Pine.LNX.4.33.0205070025140.19921-100000@bzzzt.slackware.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

With much help from Anton, I backported the NTFS-TNG driver to 2.4.x Linux
kernel series. If you are afraid of running 2.5.x kernel, but you would
like to get all benefits of the new NTFS driver use this one.

It should have all features the driver for 2.5.x has -- only 2.5.x series
specific code was removed/altered.

The driver itself really looks to be stable, it survived all the run
tests, but if you have any problems running it, please, contact me or
Anton.

You can download the patch for the vanilla 2.4.18 from:
http://prdownloads.sourceforge.net/linux-ntfs/linux-2.4.18-ntfs-2.0.6a.patch
http://prdownloads.sourceforge.net/linux-ntfs/linux-2.4.18-ntfs-2.0.6a.patch.gz
http://prdownloads.sourceforge.net/linux-ntfs/linux-2.4.18-ntfs-2.0.6a.patch.bz2

I plan also to sync the patch with the 2.4.19pre releases but it may take
some time.

pkot
-- 
Pawel Kot <pkot@linuxnews.pl>
http://www.gnokii.org/ :: http://www.slackware.pl/
http://kt.linuxnews.pl/ -- Kernel Traffic po polsku

