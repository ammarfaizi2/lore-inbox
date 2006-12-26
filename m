Return-Path: <linux-kernel-owner+w=401wt.eu-S932583AbWLZN5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWLZN5I (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 08:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWLZN5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 08:57:08 -0500
Received: from web32608.mail.mud.yahoo.com ([68.142.207.235]:38019 "HELO
	web32608.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932583AbWLZN5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 08:57:07 -0500
Message-ID: <20061226135706.58395.qmail@web32608.mail.mud.yahoo.com>
X-YMail-OSG: eqHbVa8VM1nC4vFOjzHjndsl1z5OCsOwI.ynKp4sanZEVeg21TOjxCyVZGhMf7Uddw--
X-RocketYMMF: knobi.rm
Date: Tue, 26 Dec 2006 05:57:06 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: Binary Drivers
To: James C Georgas <jgeorgas@rogers.com>, knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1167139732.15424.48.camel@Rainsong>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- James C Georgas <jgeorgas@rogers.com> wrote:

> On Tue, 2006-26-12 at 03:20 -0800, Martin Knoblauch wrote:
> > On 12/25/06, David Schwartz <davids@xxxxxxxxxxxxx> wrote:
> > 
> > >   If I bought the car from the manufacturer, it also must
> > > include any rights the manufacturer might have to the car's use.
> > > That includes using the car to violate emission control measures.
> > > If I didn't buy the right to use the car that way (insofar as
> > > that right was owned by the car manufacturer), I didn't
> > > buy the whole care -- just *some* of the rights to use it.
> > 
> >  just to be dense - what makes you think that the car manufacturer
> has
> > any legal right to violate emission control measures? What an utter
> > nonsense (sorry).
> > 
> >  So, lets stop the stupid car comparisons. They are no being funny
> any
> > more.
> 
> Let's summarize the current situation:
> 
> 1) Hardware vendors don't have to tell us how to program their
> products, as long as they provide some way to use it 
> (i.e. binary blob driver).
>

 Correct, as far as I can tell.
 
> 2) Hardware vendors don't want to tell us how to program their
> products, because they think this information is their secret
> sauce (or maybe their competitor's secret sauce).
>

 - or they are ashamed to show the world what kind of crap they sell
 - or they have lost (never had) the documentation themselves. I tend
to no believe this

> 3) Hardware vendors don't tell us how to program their products,
> because they know about (1) and they believe (2).
>

 - or they are just ignorant
  
> 4) We need products with datasheets because of our development model.
>

 - correct
 
> 5) We want products with capabilities that these vendors advertise.
>

 we want open-spec products that meet the performance of the high-end
closed-spec products
 
> 6) Products that satisfy both (4) and (5) are often scarce or
> non-existent.
>

 unfortunatelly
 
> 
> So far, the suggestions I've seen to resolve the above conflict fall
> into three categories:
> 
> a) Force vendors to provide datasheets. 
> 
> b) Entice vendors to provide datasheets.
> 
> c) Reverse engineer the hardware and write our own datasheets.
> 
> Solution (a) involves denial of point (1), mostly through the use of
> analogy and allegory. Alternatively, one can try to change the law
> through government channels.
>

  good luck
 
> Solution (b) requires market pressure, charity, or visionary
> management.
> We can't exert enough market pressure currently to make much
> difference.
> Charity sometimes gives us datasheets for old hardware. Visionary
> management is the future.
> 

 - Old hardware is not interesting in most markets
 - Visionary mamangement is rare

> Solution (c) is what we do now, with varying degrees of success. A
> good example is the R300 support in the radeon DRM module.
> 

 But the R300 does not meet 5)

Cheers
Martin

------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
