Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbTCOI3t>; Sat, 15 Mar 2003 03:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCOI3t>; Sat, 15 Mar 2003 03:29:49 -0500
Received: from comtv.ru ([217.10.32.4]:62625 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261346AbTCOI3p>;
	Sat, 15 Mar 2003 03:29:45 -0500
X-Comment-To: William Lee Irwin III
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, Andrew Morton <akpm@digeo.com>,
       adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
References: <20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313165641.H12806@schatzie.adilger.int>
	<m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com>
	<20030314205455.49f834c2.akpm@digeo.com>
	<20030315054910.GN20188@holomorphy.com>
	<20030315062025.GP20188@holomorphy.com>
	<20030314224413.6a1fc39c.akpm@digeo.com>
	<m3r899yrhx.fsf@lexa.home.net> <20030315082927.GR20188@holomorphy.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Date: 15 Mar 2003 11:32:28 +0300
In-Reply-To: <20030315082927.GR20188@holomorphy.com>
Message-ID: <m3wuj1xc6b.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> William Lee Irwin (WLI) writes:

 >> I simple use own pretty simple test. btw, you may disable
 >> preallocation to increase allocation rate

 WLI> This looks very interesting, but it may have to wait ca. 24
 WLI> hours for some benchmark time b/c of the long boot times and
 WLI> late hour in .us.

 WLI> This also looks like it would be a much better stress test, and
 WLI> the NUMA-Q is known for bringing out many rare races. There is
 WLI> are good reasons to run this test even aside from performance.

fine. it's really interesting to see results for so big iron.

