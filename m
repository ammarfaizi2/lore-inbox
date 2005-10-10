Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVJJRII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVJJRII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVJJRII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:08:08 -0400
Received: from mtl.rackplans.net ([65.39.167.249]:52438 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1750980AbVJJRIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:08:07 -0400
Date: Mon, 10 Oct 2005 13:08:05 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Direct Rendering drivers for ATI X300 ?
In-Reply-To: <Pine.LNX.4.60.0510101854470.25653@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.64.0510101307240.21395@innerfire.net>
References: <Pine.LNX.4.64.0510101230360.8804@innerfire.net>
 <Pine.LNX.4.60.0510101838580.25345@kepler.fjfi.cvut.cz>
 <Pine.LNX.4.64.0510101246580.1023@innerfire.net>
 <Pine.LNX.4.60.0510101854470.25653@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2005, Martin Drab wrote:

> Date: Mon, 10 Oct 2005 18:56:11 +0200 (CEST)
> From: Martin Drab <drab@kepler.fjfi.cvut.cz>
> To: Gerhard Mack <gmack@innerfire.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Direct Rendering drivers for ATI X300 ?
> 
> On Mon, 10 Oct 2005, Gerhard Mack wrote:
> 
> > On Mon, 10 Oct 2005, Martin Drab wrote:
> > 
> > > Have you seen this
> > > 
> > > 	http://r300.sourceforge.net/
> > > 
> > > However, I'm not sure how much useable it is allready. Perhaps not much. 
> > > Otherwise you would probably either have to stick with the ATI's binary 
> > > drivers or open source unaccelerated drivers. I'm not aware of anything 
> > > else being available for recent ATI chips.
> > 
> > Although those drivers support the card, they do not compile on recent 
> > kernels. I managed to hack it to compile and then ended up with X being 
> > unable to access the /dev/dri/card* devices.
> 
> Then check the permissions.
> 
> Martin

Strangely enough the directory is empty.. if I use mknod to create the 
files they get removed as soon as X loads.
 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
