Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288891AbSANS5G>; Mon, 14 Jan 2002 13:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288834AbSANS4T>; Mon, 14 Jan 2002 13:56:19 -0500
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:42504 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S288891AbSANSza>; Mon, 14 Jan 2002 13:55:30 -0500
Date: Mon, 14 Jan 2002 12:55:08 -0600
From: Charles Cazabon <charlesc@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou \(ETL\)" <Michael.Lazarou@etl.ericsson.se>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114125508.A3358@twoflower.internal.do>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <E16QBwD-0002So-00@the-village.bc.nu> <20020114132618.G14747@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114132618.G14747@thyrsus.com>; from esr@thyrsus.com on Mon, Jan 14, 2002 at 01:26:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com> wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Now to do everything you describe does not need her to configure a custom
> > kernel tree. Not one bit. You think apt or up2date build each user a custom
> > kernel tree ?
> 
> Is it OK in your world that Aunt Tillie is dependent on a distro maker?  Is
> it OK that she never gets to have a kernel compiled for anything above the
> least-common-denominator chip?  

Yes, and yes.  Aunt Tillie is running Linux because someone installed a
distribution for her.

She is never going to need anything out of her kernel that her vendor-shipped
update kernels do not provide.  She is never going to need the 1% performance
difference she might she if she custom-compiled a kernel for her architecture
rather than using the closest one shipped by her vendor.

> But the point of this game is for Aunt Tillie to have more and better
> choices.  Isn't that what we're supposed to be about?

No.  We're supposed to be about stuff that works.  Vendor-shipped kernels work
for 99.9% of people.  The remaining 0.1% have no need for an
"auto-configurator".

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                         <charlesc@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
