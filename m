Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946168AbWBDL1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946168AbWBDL1O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946169AbWBDL1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:27:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27117 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1946168AbWBDL1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:27:13 -0500
Date: Sat, 4 Feb 2006 11:27:12 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.15-rc2-git1-bird1
Message-ID: <20060204112712.GA27946@ftp.linux.org.uk>
References: <20051222101523.GP27946@ftp.linux.org.uk> <20051223093146.GT27946@ftp.linux.org.uk> <20051224095114.GU27946@ftp.linux.org.uk> <20051225201423.GC27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225201423.GC27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, it's back.  And this time it's finally in git - tree is on
git://git.kernel.org/pub/scm/linux/kernel/git/viro/bird.git/
There will be a lot of reordering the patchset (and hopefully flushing
it into mainline) in the next few days, so it's in flux right now.

Composite patch:
ftp://ftp.linux.org.uk/pub/people/viro/patch-2.6.16-rc2-git1-bird1.bz2

URL of splitup: same place, splitup.tar.bz2

A lot of changes - many misc fixes, a lot of endianness annotations,
a couple of new targets added since the last time.  More details when
the things settle down a bit...
