Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266841AbUBGLsn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266856AbUBGLsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:48:43 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:35712 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S266841AbUBGLrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:47:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: aRTS vs 2.6.3-rc1, aRTS loses
Date: Sat, 7 Feb 2004 06:47:54 -0500
User-Agent: KMail/1.6
References: <200402070631.26011.gene.heskett@verizon.net>
In-Reply-To: <200402070631.26011.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402070647.54889.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.53.166] at Sat, 7 Feb 2004 05:47:55 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 February 2004 06:31, Gene Heskett wrote:
>Greetings;
>
>On rebooting to 2.6.3-rc1, I get a failed advisory from aRTS that I
>didn't get with 2.6.2.
>
>Is this a known problem?  FWIW, things like tvtime continue to make
>sound ok.

Must be a known operator problem, I just rebuilt it from the 
2.6.2 .config + a make oldconfig, and its all working again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
