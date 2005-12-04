Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVLDRLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVLDRLD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 12:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVLDRLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 12:11:03 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42494 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932304AbVLDRLB (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 12:11:01 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: "tony" <hqy@nlsde.buaa.edu.cn>,
       "'Linux Kernel Mailing List'" <Linux-Kernel@vger.kernel.org>
Subject: Re: Help!Unable to handle kernel NULL pointer...
Date: Sun, 04 Dec 2005 17:10:58 +0000
Message-Id: <120420051710.17939.439323220002DD040000461322070206539D0E050B9A9D0E99@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: d2FydWRrYXJAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are running an ancient kernel (with possible security issues) and unless you have some paid support for it I doubt you will get serious help here.

Your choices are to upgrade to latest 2.4 series version 2.4.32 and hope that the problem goes away or upgrade to the latest 2.6 series and then repost if a similar problem occurs there.

Also, if the problem started happening recently and without any kernel related changes, you might want to test the hardware.

HTH
Parag



