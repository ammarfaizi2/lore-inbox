Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTJCKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 06:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbTJCKLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 06:11:15 -0400
Received: from sceptic.lug.net.nz ([203.97.5.60]:384 "EHLO sceptic.lug.net.nz")
	by vger.kernel.org with ESMTP id S263564AbTJCKLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 06:11:15 -0400
Date: Fri, 3 Oct 2003 22:24:11 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 apm suspend problem
Message-ID: <Pine.LNX.4.53.0310032213180.166@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.22, after suspending my computer the sound daemon on my system
(artsd) is stuck in an uninterruptible sleep state.

This doesn't happen with 2.4.20; I haven't tested 2.4.21.

I'm using GCC 2.95.3, binutils 2.14.90.0.4, and have the ALSA modules
v0.9.6 installed.
-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
