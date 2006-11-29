Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966417AbWK2JNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966417AbWK2JNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966439AbWK2JNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:13:54 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:63410 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S966417AbWK2JNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:13:53 -0500
Date: Wed, 29 Nov 2006 10:13:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: prajakta choudhari <prajaktachoudhari@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help for kernel module programming
In-Reply-To: <e9010580611282358p5966357cxf50c650819ba1710@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0611291012500.3813@yvahk01.tjqt.qr>
References: <e9010580611282358p5966357cxf50c650819ba1710@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi:
> I am writing a kernel module for assging an ip address to an interface.
> I  have included linux/igmp.h but still whenever i use the function

...What function?

> declared in  igmp.h file, it says unresolved symbol for that function.

...What symbol?

> I am new to this programming.
> i use the following command to compile it:
> gcc -c -D__KERNEL__   -DMODULE
> -I/home/newkernelsource/linux-2.4.22/include  hello.c

Please read the files in Documentation/kbuild/.


	-`J'
-- 
