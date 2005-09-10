Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVIJSEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVIJSEm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVIJSEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:04:42 -0400
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]:34984 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932149AbVIJSEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:04:39 -0400
Message-Id: <20050910174452.907256000@zion.home.lan>
Date: Sat, 10 Sep 2005 19:44:52 +0200
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: blaisorblade@yahoo.it
Subject: [patch 0/7] Uml merge for 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge easy part of my local Uml tree - mostly little bugfixes, and some tested
VM oneliners.

One patch (linker script change, adding dwarf debug sections) is applied to
i386 and x86-64 as well, on request(?) by Sam Ravnborg.

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
