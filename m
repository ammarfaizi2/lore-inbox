Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261621AbSJJP0u>; Thu, 10 Oct 2002 11:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSJJP0u>; Thu, 10 Oct 2002 11:26:50 -0400
Received: from thunk.org ([140.239.227.29]:28870 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261621AbSJJP0s>;
	Thu, 10 Oct 2002 11:26:48 -0400
Date: Thu, 10 Oct 2002 11:32:27 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Walter Landry <wlandry@ucsd.edu>, linux-kernel@vger.kernel.org
Subject: Re: A simple request (was Re: boring BK stats)
Message-ID: <20021010153227.GA19292@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
	Walter Landry <wlandry@ucsd.edu>, linux-kernel@vger.kernel.org
References: <20021009.163920.85414652.wlandry@ucsd.edu> <3DA58B60.1010101@pobox.com> <20021010072818.F27122@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010072818.F27122@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 07:28:18AM -0700, Larry McVoy wrote:
> 
> In low memory situations you really want to run the tree compressed.  
> ON a fast machine do a "bk -r admin -Z" and then clone that onto your
> laptop.  I think that will drop the tree to about 145MB which will
> help, maybe.  I suspect that you use enough of the rest of your 200MB
> that it still won't fit.

I believe it's the case that all of the trees on bkbits.net are
compressed, so if you originally cloned your kernel tree off of
bkbits.net, it should already be compressed.  Larry, would this be a
correct statement?

						- Ted
