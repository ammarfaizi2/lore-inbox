Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbVLRVlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbVLRVlV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 16:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbVLRVlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 16:41:21 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31396 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965281AbVLRVlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 16:41:20 -0500
Subject: Re: Unable to handle kernel NULL pointer dereference at ...
From: Lee Revell <rlrevell@joe-job.com>
To: MIHALY BAK <mihaly.bak.021@student.lth.se>
Cc: linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <42cc6ec42cea67.42cea6742cc6ec@net.lu.se>
References: <42cc6ec42cea67.42cea6742cc6ec@net.lu.se>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 16:42:41 -0500
Message-Id: <1134942161.14510.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 22:05 +0100, MIHALY BAK wrote:
> ------------
> Quick summery:
> ------------
> When I try to run Java Applets with sound inside my 32-bit chroot within a firefox 32-bit I get this the first time:
> http://www.student.lu.se/~ihpv03mba/kernel/kernellog
> and the applet never loads, the message in the kernel log only apperas the first time.

This is an ALSA bug, please report it here:

https://bugtrack.alsa-project.org/alsa-bug/main_page.php

The Quick Summary is probably enough information.

Lee

