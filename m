Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWIAHYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWIAHYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 03:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWIAHYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 03:24:47 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:29418 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964890AbWIAHYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 03:24:47 -0400
Date: Fri, 1 Sep 2006 09:22:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp with PAE
In-Reply-To: <20060831225232.GE31125@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0609010920530.25521@yvahk01.tjqt.qr>
References: <20060831135336.GL3923@elf.ucw.cz> <20060831104304.e3514401.akpm@osdl.org>
 <20060831223521.GB31125@elf.ucw.cz> <20060831154828.4313327c.akpm@osdl.org>
 <20060831225232.GE31125@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I think what this really points at is a weakness in the menuconfig/xconfig/etc
>> user interfaces.  It should be possible to navigate to the presently-disabled
>> config option and ask it "why can't I turn you on?".
>
>Yes, but I'll still have users asking me "why I can't turn it on" ;-).

That would probably be handy, just as http://lkml.org/lkml/2006/8/25/25



Jan Engelhardt
-- 
