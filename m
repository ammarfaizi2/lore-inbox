Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281808AbRLLTR4>; Wed, 12 Dec 2001 14:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281809AbRLLTRr>; Wed, 12 Dec 2001 14:17:47 -0500
Received: from mail020.mail.bellsouth.net ([205.152.58.60]:28828 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281808AbRLLTRa>; Wed, 12 Dec 2001 14:17:30 -0500
Date: Wed, 12 Dec 2001 13:17:23 -0600
From: Matthew Fredrickson <lists@fredricknet.net>
To: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Over 4-way systems considered harmful :-)
Message-ID: <20011212131723.A30408@frednet.dyndns.org>
In-Reply-To: <2436533899.1007458881@mbligh.des.sequent.com> <HBEHIIBBKKNOBLMPKCBBMEPLECAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBMEPLECAA.znmeb@aracnet.com>; from znmeb@aracnet.com on Tue, Dec 04, 2001 at 09:07:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 09:07:14PM -0800, M. Edward Borasky wrote:
> I don't see how this is a win for me. And it is a win for IBM only if it

I think what you don't seem to realize is that most developers don't
develop because they think it's good for you, or anyone else for that
matter.  Every developer has his own motivation, but I doubt that there
are a great majority of them that do it just to please others.

We don't do it for the "greater good", we do it because "it fixes this bug
that keeps hard locking my kernel whenever I play track 2 of the new cd
that came out", or "I guess nobody has written a driver for my new
seti@home-on-pci card processing board, looks like if I want it to work,
I'll have to write one".

I'm not trying to sham the greater good mentality, but I'm just trying to
tell you that most developers are primarily in it for themselves.

> Perhaps effort should be placed into software development processes and
> tools that deny race conditions the right to be born, rather than depending
> on testing on a 16-processor system to find them expeditiously :-). And

You have gcc, no?  write some tools.  I like doing driver development,
I'll keep doing that until I need a tool to help me out with something,
and then I'll write one.  Maybe I'll get lucky and someone else has
already written what I need.

Matthew Fredrickson

