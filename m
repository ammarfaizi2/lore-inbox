Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVCSSAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVCSSAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 13:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVCSSAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 13:00:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42428 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262645AbVCSSAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 13:00:18 -0500
Date: Sat, 19 Mar 2005 19:00:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Relayfs question
Message-ID: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


according to the relayfs description on opersys.com,

|As the Linux kernel matures, there is an ever increasing number of facilities
|and tools that need to relay large amounts of data from kernel space to user
|space. Up to this point, each of these has had its own mechanism for relaying
|data. To supersede the individual mechanisms, we introduce the "high-speed
|data relay filesystem" (relayfs). As such, things like LTT, printk, EVLog,
|etc.

This sounds to me like it would obsolete most character-based devices, e.g.
random and urandom.

What do the relayfs developers say to this?


Jan Engelhardt
-- 
