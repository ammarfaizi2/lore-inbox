Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWC2ACU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWC2ACU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWC2ABs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:48 -0500
Received: from [151.97.230.9] ([151.97.230.9]:31425 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S964861AbWC2ABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:39 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 0/7] UML TLS support [for 2.6.17]
Date: Wed, 29 Mar 2006 01:54:42 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060328235442.13838.26861.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is UML support for TLS, which allows one to fully use NPTL glibc,
finally, on a 2.6 host (either x86 or x86_64). This has been happily tested by
many users and by us for some times and we've now fixed all known bugs, and
tested with different glibc's. So this code can IMHO be merged finally.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
