Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRBWRvp>; Fri, 23 Feb 2001 12:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131504AbRBWRvg>; Fri, 23 Feb 2001 12:51:36 -0500
Received: from dsl-64-192-216-221.telocity.com ([64.192.216.221]:13060 "EHLO
	topgun.unixexchange.com") by vger.kernel.org with ESMTP
	id <S131497AbRBWRvX>; Fri, 23 Feb 2001 12:51:23 -0500
Date: Fri, 23 Feb 2001 12:49:56 -0500 (EST)
From: "Carl D. Speare" <carlds@attglobal.net>
X-X-Sender: <carlds@topgun.unixexchange.com>
To: David Weinehall <tao@acc.umu.se>
cc: Quim K Holland <qkholland@my-deja.com>, <linux-kernel@vger.kernel.org>
Subject: Re: need to suggest a good FS:
In-Reply-To: <20010223183423.N5465@khan.acc.umu.se>
Message-ID: <Pine.BSF.4.33.0102231247350.4409-100000@topgun.unixexchange.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, David Weinehall wrote:

> Date: Fri, 23 Feb 2001 18:34:23 +0100
> From: David Weinehall <tao@acc.umu.se>
> To: Carl D. Speare <carlds@attglobal.net>
> Cc: Quim K Holland <qkholland@my-deja.com>, linux-kernel@vger.kernel.org
> Subject: Re: need to suggest a good FS:
> On Fri, Feb 23, 2001 at 12:20:34PM -0500, Carl D. Speare wrote:
> > Actually there isn't. Hmmm, sounds like I'll have some hacking to do...
> >
> > But I have to ask if this is something that would actually be desirable.
> > Given how rare it is, does the Linux community actually want to have YAFS
> > (yet another file system) added to the list, especially for an even more
> > rare OS like OpenServer 5.0.x? Maybe now that Caldera is involved more
> > with SCO, it might be something that happens in a few months anyway...
>
> Make a read-only version; this will make transition from HTFS to
> {ext2fs, reiserfs, xfs, jfs, ...} easy. Read-only also has the property
> that it won't cause on-disk corruption; at worst, you get in-memory
> corruption...
>
>
> /David
>   _                                                                 _
>  // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
> //  Project MCA Linux hacker        //  Dance across the winter sky //
> \>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

I'll see if I can get something started this weekend. At some point, if it
gets anywhere, I'll toss is into sourceforge. I'll post a link when I get
the baseline functionality going.

--Carl

