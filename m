Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281887AbRK1G7k>; Wed, 28 Nov 2001 01:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281823AbRK1G7b>; Wed, 28 Nov 2001 01:59:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14350 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281886AbRK1G7S>;
	Wed, 28 Nov 2001 01:59:18 -0500
Date: Wed, 28 Nov 2001 07:58:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
Message-ID: <20011128075850.D23858@suse.de>
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, Linus Torvalds wrote:
> 
> On Wed, 28 Nov 2001, Paul Mackerras wrote:
> >
> > Is there a description of the new block layer and its interface to
> > block device drivers somewhere?  That would be helpful, since Ben
> > Herrenschmidt and I are going to have to convert several
> > powermac-specific drivers.
> 
> Jens has something written up, which he sent to me as an introduction to
> the patch. I'll send that out unless he does a cleaned-up version, but I'd
> actually prefer for him to do the sending. Jens?

No problem, I'll clean it up and send it out. I also planned on doing a
specific guide to converting drivers to exploit the new features.

-- 
Jens Axboe

