Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTLWUNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTLWUNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:13:23 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:721 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262386AbTLWUNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:13:20 -0500
From: David Lang <david.lang@digitalinsight.com>
To: xan2@ono.com
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Date: Tue, 23 Dec 2003 12:13:11 -0800 (PST)
Subject: RE: Re: [License of kernel components] linux-2.x.y/Documentation/logo.GIF
 should be logo.PNG?
In-Reply-To: <19af2619c848.19c84819af26@ono.com>
Message-ID: <Pine.LNX.4.58.0312231211070.6391@dlang.diginsite.com>
References: <19af2619c848.19c84819af26@ono.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 xan2@ono.com wrote:

> Gene Heskett <gene.heskett@verizon.net> wrote (23th, 2003 6:07 pm)
> >>Re: [License of kernel components] linux-2.x.y/Documentation/logo.GIF
> should be logo.PNG?
> >
> > On Tuesday 23 December 2003 10:20, xan2@ono.com wrote:
> > >Hi,
> > >
> > >I believe that the tux logo located at
> > >linux-2.6.0/Documentation/logo.gif is the image that appears on the
> > >boot of the system if framebuffer is enabled, isn't it?
> > >
> > >In this cas, and also if it's only for documentation purpose, I
> > > think that we could change the propietary (and I think patented)
> > > format of this logo (gif) to anyone that were free (for example
> > > like PNG format [that has GPL licensed]).
> >
> > I don't think GIF was ever "proprietary", but the l-z-w compression
> > used was patented.  The patent expired earlier this year.  So gif
> > is
> > back.
>
> Sorry. I'm outdated. ;-)
> But, why not support a opensource format like PNG?
> And yes, now is expired but i think that we (the kernel users) used the
> gif format one year ago (I think that it's trivial to check that 2.4.x
> series used gif format. So they (patent registers of LZW) might demand
> the money that we did not pay to their.

and changing it now would prevent this how?

it's probably less risk to just ask for permission for the next 4 months
before the patent expires then to put new image rendering code into the
kernel (it will probably take close to for months for an answer of no to
officially come back down anyway)

David Lang

> Regards,
> Xan.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
