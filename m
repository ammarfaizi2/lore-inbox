Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSHYQTX>; Sun, 25 Aug 2002 12:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSHYQTX>; Sun, 25 Aug 2002 12:19:23 -0400
Received: from pool-151-196-172-157.balt.east.verizon.net ([151.196.172.157]:22511
	"EHLO beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S317399AbSHYQTX>; Sun, 25 Aug 2002 12:19:23 -0400
Date: Sun, 25 Aug 2002 12:24:06 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Christophe Devalquenaire <C.Devalquenaire@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2.5 Problem ne.c driver
In-Reply-To: <3D68D9F1.17A9A1B0@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0208251222280.1561-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2002, Christophe Devalquenaire wrote:
> kris wrote:
> > kris wrote:
> > >
> > > I have 2 ne2000 isa cards (10Mbps for each) and with this versions of
> > > kernel the bandwith is divided by 2. So 2*5Mbps = 10Mbps instead of
> > > 2*10Mbps=20Mbps.
> > > I try to fix the pbm.
> > 
> > perhaps a bug exists on the dispatcher when 2 identical cards exist.
> > Anyone have 2 identical cards for test ?
> 
> After other tries, the ne.c file is buggy. Confirmation.
> I investigate. Anyone helps me ?

Do you have evidence of a specific problem?
Or the same hardware running faster with other drivers or kernel versions?

This sounds as if you are just running out of ISA bus bandwidth...

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

