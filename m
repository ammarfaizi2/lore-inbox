Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283231AbRLII6E>; Sun, 9 Dec 2001 03:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283233AbRLII5z>; Sun, 9 Dec 2001 03:57:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48645 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283231AbRLII5j>;
	Sun, 9 Dec 2001 03:57:39 -0500
Date: Sun, 9 Dec 2001 09:57:33 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011209085733.GA20061@suse.de>
In-Reply-To: <20011206233759.A173@earthlink.net> <20011207144836.GF12017@suse.de> <20011207145431.GI12017@suse.de> <20011207150058.GJ12017@suse.de> <20011207114046.A152@earthlink.net> <20011207164431.GA27629@suse.de> <20011209030729.A7908@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011209030729.A7908@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09 2001, rwhron@earthlink.net wrote:
> On Fri, Dec 07, 2001 at 05:44:31PM +0100, Jens Axboe wrote:
> > loop can't be trusted yet. btw, updated patch on kernel.org,
> > /pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre6
> 
> mkreiserfs on loop is working again in 2.5.1-pre8.
> 
> Linux test project runalltests.sh finished with no new
> regressions.
> 
> growfiles did more iterations in 760 seconds than I've 
> measured before.

Excellent, thanks for the feedback.

-- 
Jens Axboe

