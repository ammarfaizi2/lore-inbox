Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTISBPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 21:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbTISBPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 21:15:20 -0400
Received: from kde.informatik.uni-kl.de ([131.246.103.200]:60588 "EHLO
	dot.kde.org") by vger.kernel.org with ESMTP id S262241AbTISBPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 21:15:19 -0400
Date: Fri, 19 Sep 2003 02:58:21 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Subject: via-rhine apparently broken in 2.4.23-pre4
Message-ID: <Pine.LNX.4.56.0309190254480.18687@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unverified (due to lack of hardware) report from a user:

Updating from 2.4.22 to 2.4.23-pre4 breaks networking with an onboard VIA 
Rhine II chip.

It seems to transfer about 2 kB of data, then stall forever.

At a first look I'm not seeing anything wrong in the new code, but then 
it's already 3:20 AM ;)

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
