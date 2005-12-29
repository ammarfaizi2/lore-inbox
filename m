Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVL2Qls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVL2Qls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVL2QlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:41:18 -0500
Received: from host3-98.pool876.interbusiness.it ([87.6.98.3]:53410 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750811AbVL2Qks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:40:48 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 0/5] UML: last patches for 2.6.15
Date: Thu, 29 Dec 2005 17:38:03 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051229163803.4985.66742.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some last-minute fixes for 2.6.15 - please merge them, they've been tested
(more or less depending on the changes).

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
