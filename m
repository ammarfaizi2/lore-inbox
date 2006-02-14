Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbWBNOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbWBNOBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbWBNOBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:01:22 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:32133 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030577AbWBNOBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:01:22 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 14:59:16 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, davidsen@tmr.com,
       chris@gnome-de.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F1E234.nailMWZAGZIXB@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <1139615496.10395.36.camel@localhost.localdomain>
 <43F088AB.nailKUSB18RM0@burner>
 <200602131901.01158.dhazelton@enter.net>
In-Reply-To: <200602131901.01158.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> On Monday 13 February 2006 08:24, Joerg Schilling wrote:
> > Christian Neumair <chris@gnome-de.org> wrote:
> > > Am Freitag, den 10.02.2006, 16:06 -0500 schrieb Bill Davidsen:
> > > > The kernel could provide a list of devices by category. It doesn't have
> > > > to name them, run scripts, give descriptions, or paint them blue. Just
> > > > a list of all block devices, tapes, by major/minor and category (ie.
> > > > block, optical, floppy) would give the application layer a chance to do
> > > > it's own interpretation.
> > >
> > > Introducing more than interface for doing the same thing can be very
> > > confusing and counter-productive. You'll create new, undocumented or
> > > semi-documented interfaces which will lead to a dependency chaos.
> >
> > So you concur with me that the fact that Linux introduced another interface
> > for SCSI was onfusing and counter-productive.
>
> And look - ide-scsi is going away. So that "new" interface is disappearing.

Try to find out what's new and what's old.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
