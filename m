Return-Path: <linux-kernel-owner+w=401wt.eu-S932095AbXACU5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXACU5Y (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbXACU5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:57:24 -0500
Received: from mtl.rackplans.net ([69.90.0.18]:46256 "EHLO mtl.rackplans.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095AbXACU5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:57:23 -0500
Date: Wed, 3 Jan 2007 15:57:21 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
X-X-Sender: gmack@mtl.rackplans.net
To: Luca <kronos.it@gmail.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] radeonfb: add support for newer cards
In-Reply-To: <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
References: <20070101212551.GA19598@dreamland.darkstar.lan> 
 <20070101214442.GA21950@dreamland.darkstar.lan>  <1167696853.23340.156.camel@localhost.localdomain>
 <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Luca wrote:

> Date: Tue, 2 Jan 2007 01:38:17 +0100
> From: Luca <kronos.it@gmail.com>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
>     linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
> Subject: Re: [PATCH] radeonfb: add support for newer cards
> 
> On 1/2/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> > > Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto:
> > > > Hi Ben, Andrew,
> > > > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > > > The patch adds support for newer Radeon cards and is mainly based on
> > > > X.Org code.
> > >
> > > And - for an easier review - this is the diff between
> > > radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> > > changes not included).
> > 
> > Ah good, what I was asking for :-) I'll try to get a new patch combining
> > everything out asap.
> 
> Great, I didn't know you were working on this, I feared that the patch
> had been forgotten.
> I've a X850 (R480) here, feel free to send me any patch for testing.
> 
> Luca

Is there a list of cards this adds support for?  I'm waiting on support 
for the X1600

	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
