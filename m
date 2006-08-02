Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWHBOg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWHBOg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWHBOg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:36:26 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:5567 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750922AbWHBOgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:36:25 -0400
Date: Wed, 2 Aug 2006 16:34:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@suse.cz>
cc: Alessandro Guido <alessandro.guido.box@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Sony ACPI extras mainline inclusion
In-Reply-To: <20060802100314.GF7601@ucw.cz>
Message-ID: <Pine.LNX.4.61.0608021634370.13053@yvahk01.tjqt.qr>
References: <44CB288A.1010702@gmail.com> <20060802100314.GF7601@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I own a Sony VAIO laptop that uses ACPI for setting 
>> screen brightness
>> through the "2.6-sony_acpi4.patch" patch that has been 
>> living in -mm for a while.
>> I'd like this patch to be merged in mainline, so that I 
>> won't be forced anymore to patch
>> the kernel by hand or to use the -mm patchset.
>> Is there something that prevents this to happen?
>
>Wrong interface?
>
>Convert it to use /sys/class/backlight sysfs interface...

FWIW, the patch works without having to apply all of -mm.


Jan Engelhardt
-- 
