Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271819AbRHUSyU>; Tue, 21 Aug 2001 14:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271823AbRHUSyK>; Tue, 21 Aug 2001 14:54:10 -0400
Received: from beppo.feral.com ([192.67.166.79]:64523 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S271819AbRHUSyF>;
	Tue, 21 Aug 2001 14:54:05 -0400
Date: Tue, 21 Aug 2001 11:53:48 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jes Sorensen <jes@sunsite.dk>, "David S. Miller" <davem@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZGYc-0008SM-00@the-village.bc.nu>
Message-ID: <20010821115155.X23686-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Aug 2001, Alan Cox wrote:

> >
> > >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> >
> > >> If the firmware was out of date, update it to a known "Qlogic stamp
> > >> of approval" version.
> >
> > Alan> That requires sorting licensing out with Qlogic. I've talked to
> > Alan> them usefully about other stuff so I'll pursue it for a seperate
> > Alan> firmware loader module.
> >
> > Well getting firmware out of them tends to be up and down.
> >
> > However I just looked through the QLogic v4.27 provided driver from
> > their web site and it does in fact included firmware with a GPL
> > license.

Interesting- I should have checked- they didn't use to have GPL on the f/w.
Earlier driver versions didn't! Oops!

-matt


