Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBLPOL>; Mon, 12 Feb 2001 10:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbRBLPOB>; Mon, 12 Feb 2001 10:14:01 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:19757 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129104AbRBLPNt>;
	Mon, 12 Feb 2001 10:13:49 -0500
Message-ID: <20010212161347.A28981@win.tue.nl>
Date: Mon, 12 Feb 2001 16:13:47 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Matti Aarnio <matti.aarnio@zmailer.org>,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lkml subject line
In-Reply-To: <Pine.GSO.4.21.0102121118580.10132-100000@acms23> <20010212133324.B15688@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010212133324.B15688@mea-ext.zmailer.org>; from Matti Aarnio on Mon, Feb 12, 2001 at 01:33:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 01:33:24PM +0200, Matti Aarnio wrote:
> On Mon, Feb 12, 2001 at 11:20:40AM +0000, Guennadi Liakhovetski wrote:
> > Dear all (and list maintainers in particular)
> > 
> > Wouldn't it be a good idea to prepend all lkml subjects with [LKML] like
> > many other lists do to distinguish lkml messages from the rest.
> 
>   NO!
> 
>   Have you ever seen reply-chains resulting at such schemes ?
> 
>     Re: [FOO] Re: [FOO] Re: [FOO] Re: [FOO] subject text
> 

Matti - that is not a very good reason.

No doubt we are able to write software that prepends [FOO]
and then removes all other instances on [FOO].
Many mailing lists do precisely that.

There are advantages: distinguish personal messages from
mailing list messages, and distinguish between different
mailing lists. And disadvantages - maybe only one:
sacrificing valuable Subject: line space.

I would not be against a [LK] label.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
