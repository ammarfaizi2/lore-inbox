Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131609AbRCOIKC>; Thu, 15 Mar 2001 03:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbRCOIJx>; Thu, 15 Mar 2001 03:09:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131609AbRCOIJk>;
	Thu, 15 Mar 2001 03:09:40 -0500
Date: Thu, 15 Mar 2001 00:08:48 -0800
Message-Id: <200103150808.AAA19567@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: [UPDATE] Zerocopy against 2.4.3-pre4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Available at:

ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.3p3-1.diff.gz

This is basically identical to the networking in Alan's current
patches.  It is only provided for people who want the zerocopy
stuff but for some reason don't feel like getting all the other
changes in Alan's tree :-)))

Please report any regressions found vs. 2.4.3-pre4 vanilla, thanks.

Later,
David S. Miller
davem@redhat.com
