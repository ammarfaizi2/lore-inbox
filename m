Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269604AbUJVNgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269604AbUJVNgs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269648AbUJVNgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:36:48 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:17841 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S269524AbUJVNgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:36:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: BT848 video support dropped in 2.6.9?
Date: Fri, 22 Oct 2004 09:36:35 -0400
User-Agent: KMail/1.7
Cc: Markus Trippelsdorf <markus@trippelsdorf.net>
References: <1098447230.12289.12.camel@localhost>
In-Reply-To: <1098447230.12289.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410220936.35720.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.58.180] at Fri, 22 Oct 2004 08:36:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 08:13, Markus Trippelsdorf wrote:
>The "BT848 video for linux" item does not show up
>with menuconfig in the "Video for linux" category.
>It was there in all previous kernels that I've used.
>Am I missing something obvious?

You might try using 'make xconfig' as it is there in mine, currently 
set to build as a module and works quit well.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
