Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRJYNnd>; Thu, 25 Oct 2001 09:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRJYNnX>; Thu, 25 Oct 2001 09:43:23 -0400
Received: from mail4.home.nl ([213.51.129.228]:43997 "EHLO mail4.home.nl")
	by vger.kernel.org with ESMTP id <S273831AbRJYNnV>;
	Thu, 25 Oct 2001 09:43:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gert-Jan Rodenburg <hertog@home.nl>
To: Dale Amon <amon@vnl.com>
Subject: Re: Defaulting new questions in scripts/Configure?
Date: Thu, 25 Oct 2001 15:44:13 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011025032741.K24348@vnl.com> <20011025105921.GNXL27467.mail2.home.nl@there> <20011025140955.A4942@vnl.com>
In-Reply-To: <20011025140955.A4942@vnl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011025134409.HPFK3410.mail4.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 October 2001 15:09, Dale Amon wrote:

> > > Did I miss it or is it something that isn't there
> > > to be found?
> > >
> > > I think I'd not be the only one to find it useful
> > > to make it be seen and not heard during a
> > > make oldconfig :-)
> >
> > no "" | make oldconfig
> >
> > Not sure if it works, but in the Linux From Scratch manual they do the
> > oposite ->  yes "" | make config
>
> Jonathan Morton suggested the yes is the answer
> as well. I tested both out and diffed against one
> done manually. no seems to just die, yes does just
> the right thing.
>
> Thanks much to all who replied.


Euhm, my fault.

yes n "" | make config should work.

*note to self -> next time, check before sending in 'hints'n'tips *

Gr.

Gert-Jan
