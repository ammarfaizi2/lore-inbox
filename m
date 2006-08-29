Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWH2Mox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWH2Mox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWH2Mox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:44:53 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:49299 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932212AbWH2Mox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:44:53 -0400
Date: Tue, 29 Aug 2006 14:44:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Otavio Salvador <otavio@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Failed to setup console
In-Reply-To: <873bbfsoqv.fsf@neumann.lab.ossystems.com.br>
Message-ID: <Pine.LNX.4.61.0608291443540.9815@yvahk01.tjqt.qr>
References: <873bbfsoqv.fsf@neumann.lab.ossystems.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>I'm trying to use 2.6.18-rc5 but it doesn't work to me. I failed to
>identify what's missing or if it's a bug somewhere.
>
>My system, while booting, shows that it fails to setup a console. I'm
>attaching my .config for reference.

Precise error messages please.

You most likely lack /dev/console.



Jan Engelhardt
-- 
