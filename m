Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272088AbRIEKuz>; Wed, 5 Sep 2001 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272101AbRIEKup>; Wed, 5 Sep 2001 06:50:45 -0400
Received: from [212.93.134.61] ([212.93.134.61]:43271 "EHLO zebra.sibnet.ro")
	by vger.kernel.org with ESMTP id <S272094AbRIEKu3>;
	Wed, 5 Sep 2001 06:50:29 -0400
Date: Wed, 5 Sep 2001 14:01:52 -0400 (EDT)
From: <sacx@zebra.sibnet.ro>
To: Simon Hay <simon@haywired.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Multiple monitors
In-Reply-To: <3B93CF91.A6D59DA8@haywired.org>
Message-ID: <Pine.LNX.4.33L2.0109051400160.20601-100000@zebra.sibnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check the http://ylabs.igreconline.com ... Is a mingetty patch for
framebuffer .

Adrian Stanila

On Mon, 3 Sep 2001, Simon Hay wrote:

> Hi all,
>
> Apologies in advance if this is a question that's already been answered
> somewhere...  I'm looking for a way to install multiple (or rather, two)
> PCI/AGP cards in a machine and connect a monitor to each one, and use
> them both *in console mode* - preferably with some nice way to say
> 'assign virtual console 2 to the first screen, and 5 to the second' -
> that way you could have one tailing log files, showing 'top', whatever.
> A quick search of the web/newsgroups turned up various patches that
> looked ideal, but a closer inspection revealed that they either relied
> on you having a Hercules mono card, or only applied against kernel
> <0.99, or both...  I was just wondering if anyone's thought
> about/written a similar patch for more recent hardware/versions?  I was
> using a console Linux machine running BB (ASCII art demo -
> http://aa-project.sourceforge.net/) just to attract attention to our
> stand today and was thinking it would be really neat to have one machine
> driving several screens...
>
> Simon
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

