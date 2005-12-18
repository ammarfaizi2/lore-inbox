Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbVLRQwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbVLRQwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVLRQwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:52:30 -0500
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]:59864 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965224AbVLRQwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:52:08 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 0/4] Uml: basic fixups for 2.6.15
Date: Sun, 18 Dec 2005 17:49:16 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051218164916.441.69564.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are some important fixes for 2.6.15 to merge. A couple of them are
already in -mm, but I'm resending them anyway since they haven't been merged,
and since akpm is "non-functional". They are:

uml-arch-um-scripts-makefilerules-remove-duplicated-code.patch
uml-fix-dynamic-linking-on-some-64-bit-distros.patch

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
