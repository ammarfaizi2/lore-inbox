Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTBTRad>; Thu, 20 Feb 2003 12:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbTBTRac>; Thu, 20 Feb 2003 12:30:32 -0500
Received: from [202.41.99.9] ([202.41.99.9]:60115 "EHLO
	mail-relay-vsat2.ernet.in") by vger.kernel.org with ESMTP
	id <S266308AbTBTRab>; Thu, 20 Feb 2003 12:30:31 -0500
Date: Thu, 20 Feb 2003 23:16:10 +0500 (GMT)
From: Sahani Himanshu <honeyuee@iitr.ernet.in>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec drivers causing problem in RHL 8.0
In-Reply-To: <1045755948.1599.0.camel@laptop.fenrus.com>
Message-ID: <Pine.GSO.4.05.10302202313230.8463-100000@iitr.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2003, Arjan van de Ven wrote:

> On Thu, 2003-02-20 at 16:20, Justin T. Gibbs wrote:
> > > Hi All,
> > > 
> > > May be you will say that this has been answered somewhere, but I am not
> > > really able to understand what to do?
> > > 
> > > I recently installed RHL 8.0 on a SGI1200 server. The server has 
> > > "Adaptec AIC-7896 SCSI BIOS v2.20S1B1" installed.
> 
> iirc this is a 440GX-box-from-hell; you HAVE to use the SMP kernel on
> those.. the UP kernel doesn't have working irq routing.

This m/c is a single processor m/c. It seems that the smp kernel with RHL
8.0 is only for multi processor machine.

Regards
HimS

