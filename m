Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314502AbSD2SPu>; Mon, 29 Apr 2002 14:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSD2SPs>; Mon, 29 Apr 2002 14:15:48 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:26634 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314502AbSD2SPO>; Mon, 29 Apr 2002 14:15:14 -0400
Date: Mon, 29 Apr 2002 20:14:17 +0200
From: tomas szepe <kala@pinerecords.com>
To: Ian Molton <spyro@armlinux.org>
Cc: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>, alchemy@us.ibm.com,
        rml@tech9.net, alan@lxorguk.ukuu.org.uk, rthrapp@sbcglobal.net,
        linux-kernel@vger.kernel.org
Subject: Re: The tainted message
Message-ID: <20020429181417.GA25815@louise.pinerecords.com>
In-Reply-To: <20020429184331.3230f5ab.spyro@armlinux.org> <Pine.GSO.4.05.10204291939240.21793-100000@mausmaki.cosy.sbg.ac.at> <20020429191630.6ba84c33.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 7 days, 12:55)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  > Warning: Module %s is not open source, and as such, loading it will
> >  > make your kernel un-debuggable. Please do not submit bug reports from
> >  > a kernel with this module loaded, as they will be useless, and likely
> >  > ignored.
> >  well, that's not the truth: the kernel itself is debuggable, but we
> >  don't know about the module, and how the module interacts with the
> >  kernel.
> It absolutely IS the truth.
> what happens if an errant module clobbers kernel space?

And isn't it true any more that modules can "shadow" certain kernel functions?
T.
