Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270518AbTHQT1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270642AbTHQT1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:27:46 -0400
Received: from dsl-hkigw3g81.dial.inet.fi ([80.222.38.129]:62899 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP id S270518AbTHQT1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:27:44 -0400
Subject: Re: nforce2 lockups
From: Jussi Laako <jussi.laako@pp.inet.fi>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: Clock <clock@twibright.com>, kenton.groombridge@us.army.mil,
       linux-kernel@vger.kernel.org
In-Reply-To: <200308151738.08965.alistair@devzero.co.uk>
References: <df962fdf9006.df9006df962f@us.army.mil>
	 <20030815171521.A683@beton.cybernet.src>
	 <200308151738.08965.alistair@devzero.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1061148472.1459.3.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Aug 2003 22:27:52 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 19:38, Alistair J Strachan wrote:

> > > I found your post looking for a solution to my lockups.  I bet if you do
> > > a dmesg, you will find that your nforce2 chipset revision is 162.
> >
> > Yeah! Look:
> >
> > NFORCE2: chipset revision 162
> 
> NFORCE2: chipset revision 162
> 
> I use APIC and ACPI on my EPoX 8RDA+, and I've never had any IO problems. So 
> it seems unlikely that it is tied to a chipset revision.

I have ASUS A7N8X Deluxe mobo with nForce2 rev 162 without any problems
(if not counting unability to enabe SiI SATA DMA mode with attached
Seagate Barracuda drive).

"22:26:25  up 17 days, 11:39,  5 users,  load average: 0.06, 0.02, 0.00"


-- 
Jussi Laako <jussi.laako@pp.inet.fi>

