Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUDGRQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDGRQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:16:39 -0400
Received: from web40514.mail.yahoo.com ([66.218.78.131]:39093 "HELO
	web40514.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263823AbUDGRQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:16:37 -0400
Message-ID: <20040407171636.73813.qmail@web40514.mail.yahoo.com>
Date: Wed, 7 Apr 2004 10:16:36 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: David Weinehall <tao@acc.umu.se>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040407085733.GJ8130@khan.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Weinehall <tao@acc.umu.se> wrote:
> On Tue, Apr 06, 2004 at 06:34:50PM -0700, Sergiy
> Lozovsky wrote:
> > 
> > --- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > > Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > > 
> > > Why do you think it has been 2 pages (8KiB) for
> as
> > > long as I remember
> > > (essentially forever in Linux), and it has taken
> a
> > > _lot_ of work to shrink
> > > it to 4KiB (- size of *current)?
> > 
> > I described the possible solution (virtual stack)
> > which can easily take care of this problem for
> some
> > subsystems, or am I wrong. If code doesn't
> allocate
> > big buffers in stack my solution can make
> conversion
> > of existing code possible without _lot_ of work.
> (I'm
> > lazy - remember :-)
> 
> You know, to me the combination of lazy programmer
> rhymes poorly with
> well-written code and security audits.

Don't take my non technical comments too seriously.
Life is too short to be serious all the time. If I was
not successful in making a joke - sorry.

(there was an old joke that programmers are very lazy
people - they don't like to work, so they write
programs and computers work for them; I just quoted
this joke).

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
