Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135551AbRDST6t>; Thu, 19 Apr 2001 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135560AbRDST6g>; Thu, 19 Apr 2001 15:58:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57354 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135364AbRDST42>;
	Thu, 19 Apr 2001 15:56:28 -0400
Date: Thu, 19 Apr 2001 21:56:02 +0200
From: Jens Axboe <axboe@suse.de>
To: AJ Lewis <lewis@sistina.com>
Cc: linux-lvm@sistina.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jes Sorensen <jes@linuxcare.com>, linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org, Arjan van de Ven <arjanv@redhat.com>,
        Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
Message-ID: <20010419215602.F30135@suse.de>
In-Reply-To: <20010419142400.E10345@sistina.com> <200104191945.f3JJjKRn015661@webber.adilger.int> <20010419145337.K10345@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010419145337.K10345@sistina.com>; from lewis@sistina.com on Thu, Apr 19, 2001 at 02:53:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, AJ Lewis wrote:
> As far as getting patches into the stock kernel, we've been sending patches
> to Linus for over a month now, and none of them have made it in.  Maybe
> someone has some pointers on how we get our code past his filters.

The diff between 2.4.4-pre LVM and your last beta is HUGE. That's a very
good clue why Linus hasn't taken it! Find a bug, fix it, submit diff.
Not find lots of bugs for a month, submit huge diff.

-- 
Jens Axboe

