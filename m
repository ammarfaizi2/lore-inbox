Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263418AbRFNVQT>; Thu, 14 Jun 2001 17:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbRFNVQJ>; Thu, 14 Jun 2001 17:16:09 -0400
Received: from beppo.feral.com ([192.67.166.79]:18702 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S263418AbRFNVP5>;
	Thu, 14 Jun 2001 17:15:57 -0400
Date: Thu, 14 Jun 2001 14:14:56 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Riley Williams <rhw@MemAlpha.CX>
cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Shawn Starr <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Gigabit Intel NIC? - Intel Gigabit Ethernet Pro/1000T
In-Reply-To: <Pine.LNX.4.33.0106142155360.16844-100000@infradead.org>
Message-ID: <20010614140835.T22077-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for jumping in late in this thread....

With respect to Intel- I've had a number of meetings with these folks on just
this topic- mostly trying to work these issues from the *BSD side of our
house.

Basically- as far as I understand what they've said, is that they're trying
to figure out how they can:

	Formulate a different NDA than they currently have set up for
	companies. This NDA means that they can release documents to engineers
	writing software *and* allow the engineers to release a driver under
	some kind of Open Source- *possibly* with a feature set less than that
	described in the documents.

My personal estimation is that they're serious about trying to do this. As the
engineers I've talked to have put it (roughly), "The Intel IP is *not* in the
)!*$)!*$!)*$ Chip APIs!". This will probably take a Very Long Time for them to
implement though. They may not, ultimately,  be able to figure it out. The
jury's still out.

If any of you want to talk to the Intel folks who are dealing with this (at
least from the marketing side of the Lan group), contact me and I can try and
put you in touch with those people.


-matt



On Thu, 14 Jun 2001, Riley Williams wrote:

> Hi Ion.
>
>  >> Shawn, I'd suggest you tell the said sales guy that IF he can
>  >> get you the FULL specs TOGETHER WITH permission to freely
>  >> distribute them...
>
>  > Permission to freely distribute the specs isn't necessary,
>  > although it is nice indeed. All that's needed is permission to
>  > GPL the driver sources written using knowledge from said specs.
>
> That presupposes that the person they give the specs to is the person
> writing the driver. I don't remember shawn offering to write a driver
> or anything approaching that.
>
> As I see it, if Shawn has permission to freely distribute the specs,
> he can send a copy to Alan Cox for forwarding to the relevant driver
> developers. However, if he has to sign an NDA to get them, they're
> useless...
>
> Alan: Am I right in assuming this?
>
> Best wishes from Riley.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

