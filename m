Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBWRWT>; Fri, 23 Feb 2001 12:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBWRWK>; Fri, 23 Feb 2001 12:22:10 -0500
Received: from dsl-64-192-216-221.telocity.com ([64.192.216.221]:11268 "EHLO
	topgun.unixexchange.com") by vger.kernel.org with ESMTP
	id <S129093AbRBWRV5>; Fri, 23 Feb 2001 12:21:57 -0500
Date: Fri, 23 Feb 2001 12:20:34 -0500 (EST)
From: "Carl D. Speare" <carlds@attglobal.net>
X-X-Sender: <carlds@topgun.unixexchange.com>
To: David Weinehall <tao@acc.umu.se>
cc: Quim K Holland <qkholland@my-deja.com>, <linux-kernel@vger.kernel.org>
Subject: Re: need to suggest a good FS:
In-Reply-To: <20010223143235.E5465@khan.acc.umu.se>
Message-ID: <Pine.BSF.4.33.0102231216030.4359-100000@topgun.unixexchange.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually there isn't. Hmmm, sounds like I'll have some hacking to do...

But I have to ask if this is something that would actually be desirable.
Given how rare it is, does the Linux community actually want to have YAFS
(yet another file system) added to the list, especially for an even more
rare OS like OpenServer 5.0.x? Maybe now that Caldera is involved more
with SCO, it might be something that happens in a few months anyway...

--Carl

On Fri, 23 Feb 2001, David Weinehall wrote:

> Received: from localhost (localhost.unixexchange.com [127.0.0.1])
> 	by topgun.unixexchange.com (8.11.1/8.11.1) with ESMTP id
>     f1NH24t04182
> 	for <carlds@localhost>; Fri, 23 Feb 2001 12:02:04 -0500 (EST)
> 	(envelope-from tao@acc.umu.se)
> Received: from pop4.prserv.net [32.97.166.5]
> 	by localhost with POP3 (fetchmail-5.5.6)
> 	for carlds@localhost (single-drop); Fri, 23 Feb 2001 12:02:04 -0500 (EST)
> Received: from khan.acc.umu.se ([130.239.18.139])
>           by prserv.net (in3) with ESMTP
>           id <20010223133237103013haume>; Fri, 23 Feb 2001 13:32:37 +0000
> Received: (from tao@localhost)
> 	by khan.acc.umu.se (8.11.2/8.11.2) id f1NDWZq17714;
> 	Fri, 23 Feb 2001 14:32:35 +0100 (MET)
> Date: Fri, 23 Feb 2001 14:32:35 +0100
> From: David Weinehall <tao@acc.umu.se>
> To: Carl D. Speare <carlds@attglobal.net>
> Cc: Quim K Holland <qkholland@my-deja.com>, linux-kernel@vger.kernel.org
> Subject: Re: need to suggest a good FS:
> Message-ID: <20010223143235.E5465@khan.acc.umu.se>
> References: <200102230127.RAA01303@mail18.bigmailbox.com>
>     <Pine.BSF.4.33.0102222229370.818-100000@topgun.unixexchange.com>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> User-Agent: Mutt/1.2.4i
> In-Reply-To:
>     <Pine.BSF.4.33.0102222229370.818-100000@topgun.unixexchange.com>; from
>     carlds@attglobal.net on Thu, Feb 22, 2001 at 10:35:06PM -0500
>
> On Thu, Feb 22, 2001 at 10:35:06PM -0500, Carl D. Speare wrote:
> > HTFS, which is the default filesystem for SCO OpenServer 5, is pretty
> > rare.
>
> I didn't know there was HTFS support in the Linux-kernel?!
>
> Oh, btw, I think I just came up with the perfect file-system; CBMFS.
> Feel welcome to get patches from my homepage. Guaranteed to
>
> a.) Not work as a baseline OS (I'll probably accept patches to make it
> do so, though)
> b.) Drive you nuts
> c.) Make you feel coooooool
> d.) Allow you to use .d64's and 1581-disks from your dear C64/C128
>
> http://www.acc.umu.se/~tao/ (Have a look in the Linux-section)
>
>
> /David
>   _                                                                 _
>  // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
> //  Project MCA Linux hacker        //  Dance across the winter sky //
> \>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
>

