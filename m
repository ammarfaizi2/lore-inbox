Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130291AbRBASeL>; Thu, 1 Feb 2001 13:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130601AbRBASeB>; Thu, 1 Feb 2001 13:34:01 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:62702 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130291AbRBASdo>; Thu, 1 Feb 2001 13:33:44 -0500
Date: Thu, 1 Feb 2001 16:32:48 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@caldera.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <E14ONzo-0004kq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102011628590.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Alan Cox wrote:

> > Sure.  But Linus saing that he doesn't want more of that (shit, crap,
> > I don't rember what he said exactly) in the kernel is a very good reason
> > for thinking a little more aboyt it.
> 
> No. Linus is not a God, Linus is fallible, regularly makes mistakes and
> frequently opens his mouth and says stupid things when he is far too busy.

People may remember Linus saying a resolute no to SMP
support in Linux ;)

In my experience, when Linus says "NO" to a certain
idea, he's usually objecting to bad design decisions
in the proposed implementation of the idea and the
lack of a nice alternative solution ...

... but as soon as a clean, efficient and maintainable
alternative to the original bad idea surfaces, it seems
to be quite easy to convince Linus to include it.

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
