Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbSLRAnF>; Tue, 17 Dec 2002 19:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbSLRAnF>; Tue, 17 Dec 2002 19:43:05 -0500
Received: from jdike.solana.com ([198.99.130.100]:65409 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S267043AbSLRAnD>;
	Tue, 17 Dec 2002 19:43:03 -0500
Message-Id: <200212180054.gBI0s0D11497@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.5.52-1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Dec 2002 19:54:00 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates UML to 2.5.52.  As far as UML itself is concerned, this
is identical to all recent 2.5 UML releases.

The file corruption that I saw with the 2.5.50 UML seems to be gone; however
Oleg Drokin is maintaining his own 2.5 UML repo, with forward ports of my 2.4
updates, and he's reporting corruption with his 2.5.52.  I've exercised this
patch with kernel builds and various other loads and seen no problem, so it's
possible the problem is in his pool and not mine - however, caveat user.

The 2.5.52 UML patch is available at
        http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.52-1.bz2
 
For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org
				Jeff
