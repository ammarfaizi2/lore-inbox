Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316652AbSFKCh3>; Mon, 10 Jun 2002 22:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSFKCh2>; Mon, 10 Jun 2002 22:37:28 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:45249 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316652AbSFKCh2>; Mon, 10 Jun 2002 22:37:28 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Andi Kleen <ak@muc.de>
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
Date: Tue, 11 Jun 2002 12:34:31 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17HYSZ-0000CY-00@pmenage-dt.ensim.com> <200206110932.44185.bhards@bigpond.net.au> <m3y9dmimbb.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206111234.31228.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 12:25, Andi Kleen wrote:
> Brad Hards <bhards@bigpond.net.au> writes:
> > I simply don't grok those pages. I also note caveats about
> > incompleteness, and recommendation to use libnetlink, which is also not
> > documented much.
>
> I'm sorry you don't like my manpages.
Make no mistake. I do like them. I am relying on them now. I just need more 
explanation and examples.

> I also wrote some manpages on libnetlink, but for some reason they were
> never merged in the main distribution so you can only find them in the SuSE
> rpm or at http://www.firstfloor.org/~andi/man/libnetlink.3.gz (source) or
> http://www.firstfloor.org/~andi/man/libnetlink.3.txt (formatted manpage)
Thanks.
> Jamal Hadi wrote a ietf draft on netlink.  I don't know if it's publicly
> available (if yes probably somewhere on ftp.ietf.org) it describes quite
> a lot of basic concepts in netlink/rtnetlink although in a bit foreign
> to linux terminology.
Thanks again. Found it at 
ftp://ftp.isi.edu/in-notes/search.ietf.org/internet-drafts/draft-ietf-forces-netlink-03.txt

> I also did a presentation on netlink and related topics at previous to
> last year's Ottawa Linux symposium which may be also helpful. The slides
> are at http://www.firstfloor.org/~andi/ols/OLSpres.htm
Its all coming together. Thanks again.

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
