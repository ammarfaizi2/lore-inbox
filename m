Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319463AbSILGx1>; Thu, 12 Sep 2002 02:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319464AbSILGx1>; Thu, 12 Sep 2002 02:53:27 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:39642 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S319463AbSILGx0>; Thu, 12 Sep 2002 02:53:26 -0400
Subject: Re: PCI: device 00:00.0 has unknown header type 7f, ignoring.
From: Nicholas Miell <nmiell@attbi.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <alp8ec$cb5$1@cesium.transmeta.com>
References: <1031798190.1499.8.camel@entropy> 
	<alp8ec$cb5$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 23:58:09 -0700
Message-Id: <1031813891.1774.1.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 22:24, H. Peter Anvin wrote:
> Followup to:  <1031798190.1499.8.camel@entropy>
> By author:    Nicholas Miell <nmiell@attbi.com>
> In newsgroup: linux.dev.kernel
> >
> > I've been getting this message since, oh, the dawn of time or so.
> > I finally worked up enough curiosity to attempt to figure out what the
> > mysterious 7f header is, but the PCI specs require money.
> > 
> > So, anyone out there happen to know what header 7f is, and why the
> > kernel doesn't recognize it?
> >  
> 
> What northbridge (chipset) does your system have?
> 

Sorry, I have no idea. It's a Compaq Deskpro 4000 5133 from 1998 or so
that I obtained second-hand, with no documentation, and neither the
Compaq website nor an inspection of the motherboard has anything useful.
 
- Nicholas

