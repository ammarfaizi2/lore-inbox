Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTIOWQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbTIOWQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:16:08 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:32730 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S261667AbTIOWQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:16:05 -0400
Date: Mon, 15 Sep 2003 23:59:37 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre4-pac1 ALSA+preemptible kernel
Message-ID: <Pine.LNX.4.56.0309152354580.20178@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've ported some popular patches to the -pac branch [they are not 
currently in -pac, and I have no immediate plans to add them directly to 
-pac]:

preempt-kernel-2.4.23-pre4-pac1 -- preemptible kernel patch
alsa-0.9.6-2.4.23 -- patch for ALSA 0.9.6 drivers to build [and work] with
                     2.4.23-pre4-pac1

both can be found in

/pub/linux/kernel/people/bero/2.4/extra/

on your favourite kernel.org mirror.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
