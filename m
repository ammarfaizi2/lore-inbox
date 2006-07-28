Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWG1E4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWG1E4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 00:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWG1E4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 00:56:14 -0400
Received: from 1wt.eu ([62.212.114.60]:2573 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S932573AbWG1E4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 00:56:12 -0400
Date: Fri, 28 Jul 2006 06:55:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux v2.4.33-rc3 (and a new v2.4 maintainer)
Message-ID: <20060728045507.GC17478@1wt.eu>
References: <200607280216.k6S2GgiJ009955@harpo.it.uu.se> <nbuic2ljd8n5g43k74tussq2hm5nvrn04e@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nbuic2ljd8n5g43k74tussq2hm5nvrn04e@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 12:46:31PM +1000, Grant Coady wrote:
> On Fri, 28 Jul 2006 04:16:42 +0200 (MEST), Mikael Pettersson <mikpe@it.uu.se> wrote:
> 
> >On Thu, 27 Jul 2006 18:30:19 -0300, Marcelo Tosatti wrote:
> >>Here goes the third (and hopefully last) release candidate of v2.4.33.
> >
> >http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.33-rc3.bz2
> >is only 854 bytes long, and once bunzip2:ed it looks like it's the
> >incremental diff between rc2 and rc3. Usually the full pre/rc patches
> >go in testing/ with the incrementals going into testing/incr/.
> >
> >No big deal, but it would feel better with a proper -rc3 patch there.
> >
> 
> Yeah, stuff happens ;)  

I will let Marcelo fix it.

> At the moment one needs 2.4.32 plus patches -rc2 and -rc3, like you 
> say, very obvious from patch file sizes ;)
> 
> At least -rc3 goes okay on 7 of 7 test boxen here: 
>   <http://bugsplatter.mine.nu/test/linux-2.4/>

Fine, thanks for the test, Grant. I expect to release hf32.7 soon, all
the patches are already waiting in the git tree. But I won't announce
a date anymore, everytime I did so I did not respect it at all.

> Cheers,
> Grant.

Cheers,
Willy

