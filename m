Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUAWA23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 19:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266493AbUAWA22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 19:28:28 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:5137 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S266492AbUAWA20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 19:28:26 -0500
Date: Thu, 22 Jan 2004 18:40:17 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia drivers and 2.6.x kernel
Message-ID: <20040122234016.GB18316@widomaker.com>
References: <200401221004.06645.chakkerz@optusnet.com.au> <400FB4AA.8000109@yahoo.com.br> <200401222252.41853.chakkerz@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401222252.41853.chakkerz@optusnet.com.au>
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, 22 Jan 2004 @ 22:52 +1100, Christian Unger said:

> Well ... i've applied the patch and downloaded the pre-patched drivers, 
> sacrificed a virgin, installed the module loading stuff (just in case) and 
> still no joy. 
> 
> So i think the fault is not with NVidia. or the patch. Maybe it's a flaw in 
> Slackware 9.1, or i'm just too thick. 

I have no problem myself.

I use the driver *.run files that have been patched to work with 2.6 
kernels.

I don't have to build a thing, I just install them like I would under
kernel 2.4.

If you look at the minion website, there is a mirror in the download
list, and that mirror has install packages modified for 2.6.

It's completely automatic.

Maybe you should try that.

It will fail when it goes to the nvidia website to find precompiled glue
code, and then proceed to build the glue locally.


-- 
UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM maker.com
