Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUERTsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUERTsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 15:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUERTsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 15:48:09 -0400
Received: from pop.gmx.net ([213.165.64.20]:41704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263088AbUERTsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 15:48:02 -0400
X-Authenticated: #20450766
Date: Tue, 18 May 2004 21:47:56 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Kurt Garloff <garloff@suse.de>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
In-Reply-To: <20040518184527.GC4859@tpkurt.garloff.de>
Message-ID: <Pine.LNX.4.44.0405182140050.3207-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2004, Kurt Garloff wrote:

> On Tue, May 11, 2004 at 02:54:33PM -0500, James Bottomley wrote:
> > On Tue, 2004-05-11 at 14:29, Guennadi Liakhovetski wrote:
> > > I hoped the tmscsim 64-bit bugfix would somehow find its way into the
> > > mainstream after 2.6. Does it still have a chance?
> >
> > The DC390 is a maintained driver:
> >
> > DC390/AM53C974 SCSI driver
> > P:	Kurt Garloff
> > M:	garloff@suse.de
> > W:	http://www.garloff.de/kurt/linux/dc390/
> > S:	Maintained
> >
> > You need to get the maintainer to approve acceptance.
>
> Granted ;-)
>
> Actually, I had discussed the patch before with Guennadi and agreed to
> it. As I don't really have much time any more for it, I would suggest
> that Guennadi takes over, if he wants to.

Well, Kurt, thanks for the offer. I am prepared and willing to do the work
on supporting the driver, but I am, perhaps, not skilled enough to be a
maintainer of a SCSI LDD. My knowledge of the SCSI protocol and the SCSI
Linux subsystem is pretty limited. On one hand, the driver is little used,
so, even if I badly break something it is not likely to cause major
problems. On the other hand, I would feel more comfortable if, at least at
the beginning, somebody would review my patches. Besides, it would be a
good opportunity for me to really learn a bit more about SCSI, SCSI Linux
driver, BIO,...  oh well...

Thanks
Guennadi
---
Guennadi Liakhovetski


