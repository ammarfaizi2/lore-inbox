Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRIELC0>; Wed, 5 Sep 2001 07:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272093AbRIELCR>; Wed, 5 Sep 2001 07:02:17 -0400
Received: from [212.93.134.61] ([212.93.134.61]:65031 "EHLO zebra.sibnet.ro")
	by vger.kernel.org with ESMTP id <S272092AbRIELCG>;
	Wed, 5 Sep 2001 07:02:06 -0400
Date: Wed, 5 Sep 2001 14:13:50 -0400 (EDT)
From: <sacx@zebra.sibnet.ro>
To: Simon Hay <simon@haywired.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Multiple monitors
In-Reply-To: <Pine.LNX.4.33L2.0109051400160.20601-100000@zebra.sibnet.ro>
Message-ID: <Pine.LNX.4.33L2.0109051408480.20601-100000@zebra.sibnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Only now I read the whole tread about 'Multiple monitors' :))
For console mode you can try my patch for mingetty (see
http://ylabs.igreconline.com is working very well.. for example at my home
I run a fbtv on another monitor and in another monitor I work)  or you can
try fbgetty . And for X use xinerama .

Adrian Stanila
P.S. is working for all combination of video cards. :))

On Wed, 5 Sep 2001 sacx@zebra.sibnet.ro wrote:

>
> Check the http://ylabs.igreconline.com ... Is a mingetty patch for
> framebuffer .
>
> Adrian Stanila
>
> On Mon, 3 Sep 2001, Simon Hay wrote:
>
> > Hi all,
> >
> > Apologies in advance if this is a question that's already been answered
> > somewhere...  I'm looking for a way to install multiple (or rather, two)
> > PCI/AGP cards in a machine and connect a monitor to each one, and use
> > them both *in console mode* - preferably with some nice way to say
> > 'assign virtual console 2 to the first screen, and 5 to the second' -
> > that way you could have one tailing log files, showing 'top', whatever.
> > A quick search of the web/newsgroups turned up various patches that
> > looked ideal, but a closer inspection revealed that they either relied
> > on you having a Hercules mono card, or only applied against kernel
> > <0.99, or both...  I was just wondering if anyone's thought
> > about/written a similar patch for more recent hardware/versions?  I was
> > using a console Linux machine running BB (ASCII art demo -
> > http://aa-project.sourceforge.net/) just to attract attention to our
> > stand today and was thinking it would be really neat to have one machine
> > driving several screens...
> >
> > Simon
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

