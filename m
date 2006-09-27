Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965351AbWI0F4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351AbWI0F4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965352AbWI0F4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:56:33 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:27279 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965351AbWI0F4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:56:32 -0400
Date: Wed, 27 Sep 2006 07:55:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sergey Panov <sipan@sipan.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159319508.16507.15.camel@sipan.sipan.org>
Message-ID: <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <1159319508.16507.15.camel@sipan.sipan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Fuzzy (but realistic) logic:
>
>   kernel != operating_system
>
>   operating_system > kernel
>
>   operating_system - kernel = 0
>
>   kernel - (operating_system - kernel) < 0
>
>Another (license compatibility) Q. is:
>    If the (operating_system - kernel) is re-licensed under v.3 and
>    the kernel is still under v.2 , would it be possible to distribute
>    combination (kernel + (operating_system - kernel)) ?

If by operating system you mean the surrounding userland application, 
then yes, why should there be a problem with a GPL2 kernel and a GPL3 
userland? After all, the userland is not only GPL, but also BSD and 
other stuff.

>The last Q. is how good is the almost forgotten Hurd kernel?

Wild guess: At most on par with Minix.



Jan Engelhardt
-- 
