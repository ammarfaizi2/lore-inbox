Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313675AbSDPNgf>; Tue, 16 Apr 2002 09:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313676AbSDPNge>; Tue, 16 Apr 2002 09:36:34 -0400
Received: from [195.223.140.120] ([195.223.140.120]:63792 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313675AbSDPNgd>; Tue, 16 Apr 2002 09:36:33 -0400
Date: Tue, 16 Apr 2002 15:36:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <20020416153619.A25328@dualathlon.random>
In-Reply-To: <20020416013016.GA23513@matchmail.com> <Pine.LNX.4.44L.0204160126510.1960-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 01:27:26AM -0300, Rik van Riel wrote:
> On Tue, Apr 16, 2002 at 02:44:58AM +0200, Andrea Arcangeli wrote:
> > On Mon, Apr 15, 2002 at 04:20:58PM -0700, William Lee Irwin III wrote:
> > > I won't scream too loud, but I think it's pretty much done right as is.
> >
> > Regardless if that's the cleaner implementation or not, I don't see much
> > the point of merging those cleanups in 2.4 right now: it won't make any
> > functional difference to users and it's only a self contained code
> > cleanup, while other patches that make a runtime difference aren't
> > merged yet.
> 
> Sorry to say it, but if you want patches to be merged, why
> don't you submit them ?

I submitted these in a past email:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/vm-33/aa-*

Andrea
