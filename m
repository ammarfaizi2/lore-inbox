Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTJ2UGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTJ2UGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:06:31 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:34822 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S261575AbTJ2UGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:06:30 -0500
Message-ID: <3FA01DB6.6080106@enterprise.bidmc.harvard.edu>
Date: Wed, 29 Oct 2003 15:06:14 -0500
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Javier Villavicencio <jvillavicencio@arnet.com.ar>,
       linux-kernel@vger.kernel.org
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
References: <Pine.LNX.4.44.0310291443180.1630-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310291443180.1630-100000@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>There have been no radeonfb changes in 2.4.23-pre, what has been updated 
>is DRM.
>
>Are you using DRM? 
>  
>
Sorry Marcelo, dain bramage on my part.  I meant 2.4.22-pre.  I think it 
was -pre3 that upgraded drivers/video/radeonfb.c from version 0.1.4 to 
version 0.1.8-ben

I guess the newer 0.1.8 is needed to support Radeon 9600's.  I'm curious 
as to whether other people have the same massive screen corruption 
problems returning from X as I do.  If not, probably best to keep the 
new driver.  (Maybe I should go out and buy myself a new Radeon. :-)  I 
have been using ATI's private DRI/DRM kernel module driver (fglrx) in 
concert with XFree 4.2.0 for quite some time.

Kris

