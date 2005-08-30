Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVH3JyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVH3JyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVH3JyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:54:04 -0400
Received: from postman2.arcor-online.net ([151.189.20.157]:3528 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S1750818AbVH3JyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:54:03 -0400
Date: Tue, 30 Aug 2005 11:53:59 +0200
From: Tino Keitel <tino.keitel@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sr device can be written?
Message-ID: <20050830095359.GA15431@localhost.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <c3c37c55050829215355bb85f4@mail.gmail.com> <20050830080812.GA13394@localhost.localdomain> <7cd5d4b40508300111260d6b9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd5d4b40508300111260d6b9a@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 16:11:58 +0800, jeff shia wrote:
> YOu mean the device file can be written?

Yes, like an ordinary block device.

> 
> 
> On 8/30/05, Tino Keitel <tino.keitel@gmx.de> wrote:
> > On Tue, Aug 30, 2005 at 12:53:51 +0800, jeff shia wrote:
> > > Hello,
> > >  Sr is the Scsi-cdrom device?so it can be read only?but look at the source=
> > > =20
> > > code I notice that
> > > sr can be written also!Is it right?
> > 
> > Just imagine a DVD-RAM drive.
> > 
> > Regards,
> > Tino
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
