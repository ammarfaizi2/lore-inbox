Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbSAUQTV>; Mon, 21 Jan 2002 11:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287306AbSAUQTL>; Mon, 21 Jan 2002 11:19:11 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:31369 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287303AbSAUQTA>;
	Mon, 21 Jan 2002 11:19:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rob Landley <landley@trommello.org>, Russell King <rmk@arm.linux.org.uk>,
        "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Date: Mon, 21 Jan 2002 17:22:35 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020115145324.A5772@thyrsus.com> <20020115202518.G1822@flint.arm.linux.org.uk> <20020116034150.CRKF26021.femail12.sdc1.sfba.home.com@there>
In-Reply-To: <20020116034150.CRKF26021.femail12.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ShDP-0001ic-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 08:37 pm, Rob Landley wrote:
> On Tuesday 15 January 2002 03:25 pm, Russell King wrote:
> > On Tue, Jan 15, 2002 at 02:53:24PM -0500, Eric S. Raymond wrote:
> > > 	* The `vitality' flag is gone from the language.  Instead, the
> > > 	  autoprober detects the type of your root filesystem and forces
> > > 	  its symbol to Y.
> >
> > This seems like a backwards step.  What's the reasoning for breaking the
> > ability to configure the kernel for a completely different machine to the
> > one that you're running the configuration/build on?
> 
> He didn't.  If you want to do that, run "make menuconfig" instead of "make 
> autoconfigure".

I detect a slight lack of symmetry here, shouldn't it be "make autoconfig"?
Pardon me if this has been beaten to^W^W discussed above.

--
Daniel
