Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbSI2Ueg>; Sun, 29 Sep 2002 16:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSI2Uef>; Sun, 29 Sep 2002 16:34:35 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.232.94]:30212
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261777AbSI2Uee>; Sun, 29 Sep 2002 16:34:34 -0400
Date: Sun, 29 Sep 2002 16:42:13 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic/exception dump support in 2.5?
Message-ID: <Pine.LNX.4.44.0209291640030.594-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It would really be nice if I could capture kernel exceptions/and oopsies
on a file, or over a network connection. Redirecting console=lp0 to
printer doesnt really let me paste dumps to LKML =)

Any solutions? Will we have a way to properly dump kernel failures
(exceptions/oopies) somewhere?

--
Shawn Starr, sh0n.net, <spstarr@sh0n.net>
Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/

