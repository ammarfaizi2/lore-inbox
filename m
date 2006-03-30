Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWC3GSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWC3GSP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWC3GSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:18:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2126 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751110AbWC3GSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:18:14 -0500
Date: Thu, 30 Mar 2006 08:17:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330061758.GD13476@suse.de>
References: <20060329122841.GC8186@suse.de> <442A8883.9060909@garzik.org> <Pine.LNX.4.64.0603291159150.15714@g5.osdl.org> <20060329204216.GB13476@suse.de> <20060329204316.GC13476@suse.de> <Pine.LNX.4.64.0603291313120.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603291313120.15714@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Linus Torvalds wrote:
> 
> 
> On Wed, 29 Mar 2006, Jens Axboe wrote:
> > 
> > git://brick.kernel.dk/data/git/linux-2.6-block.git splice
> > 
> > is the url, just in case.
> 
> Btw, would you mind if I just re-created that as a single patch instead? 
> Especially with the first commit being slightly corrupt (look at the first 
> line of the commit message ;), and some of the later commits just fixing 
> things up further, it would appear to be cleaner to just merge it as a 
> single "initial splice support" commit..

I'll make the suggestions made while I was gone sleeping and rebase a
single patch on top of current HEAD.

-- 
Jens Axboe

