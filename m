Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283204AbRLIIEw>; Sun, 9 Dec 2001 03:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283203AbRLIIEm>; Sun, 9 Dec 2001 03:04:42 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:53687 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S283200AbRLIIE0>; Sun, 9 Dec 2001 03:04:26 -0500
Date: Sun, 9 Dec 2001 03:07:29 -0500
To: Jens Axboe <axboe@suse.de>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011209030729.A7908@earthlink.net>
In-Reply-To: <20011206233759.A173@earthlink.net> <20011207144836.GF12017@suse.de> <20011207145431.GI12017@suse.de> <20011207150058.GJ12017@suse.de> <20011207114046.A152@earthlink.net> <20011207164431.GA27629@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207164431.GA27629@suse.de>; from axboe@suse.de on Fri, Dec 07, 2001 at 05:44:31PM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 05:44:31PM +0100, Jens Axboe wrote:
> loop can't be trusted yet. btw, updated patch on kernel.org,
> /pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre6

mkreiserfs on loop is working again in 2.5.1-pre8.

Linux test project runalltests.sh finished with no new
regressions.

growfiles did more iterations in 760 seconds than I've 
measured before.

-- 
Randy Hron

