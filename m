Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWC2VPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWC2VPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWC2VPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:15:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750975AbWC2VPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:15:04 -0500
Date: Wed, 29 Mar 2006 13:14:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
In-Reply-To: <20060329204316.GC13476@suse.de>
Message-ID: <Pine.LNX.4.64.0603291313120.15714@g5.osdl.org>
References: <20060329122841.GC8186@suse.de> <442A8883.9060909@garzik.org>
 <Pine.LNX.4.64.0603291159150.15714@g5.osdl.org> <20060329204216.GB13476@suse.de>
 <20060329204316.GC13476@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Mar 2006, Jens Axboe wrote:
> 
> git://brick.kernel.dk/data/git/linux-2.6-block.git splice
> 
> is the url, just in case.

Btw, would you mind if I just re-created that as a single patch instead? 
Especially with the first commit being slightly corrupt (look at the first 
line of the commit message ;), and some of the later commits just fixing 
things up further, it would appear to be cleaner to just merge it as a 
single "initial splice support" commit..

		Linus
