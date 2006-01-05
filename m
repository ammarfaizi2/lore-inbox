Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWAEGVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWAEGVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWAEGVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:21:33 -0500
Received: from xenotime.net ([66.160.160.81]:35051 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752021AbWAEGVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:21:32 -0500
Date: Wed, 4 Jan 2006 22:21:30 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: john.l.villalovos@intel.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] MAINTAINERS file: Fix missing colon
Message-Id: <20060104222130.507d6877.rdunlap@xenotime.net>
In-Reply-To: <4d8e3fd30601041525i4e23e3bbl26ad3590c2dd80ac@mail.gmail.com>
References: <43BC45DE.5060303@intel.com>
	<Pine.LNX.4.58.0601041406210.19134@shark.he.net>
	<4d8e3fd30601041525i4e23e3bbl26ad3590c2dd80ac@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006 00:25:34 +0100 Paolo Ciarrocchi wrote:

> On 1/4/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Wed, 4 Jan 2006, John L. Villalovos wrote:
> >
> > > From: John L. Villalovos <john.l.villalovos@intel.com>
> > >
> > > While parsing the MAINTAINERS file I disovered one entry was missing a colon.
> > > This patch adds the one missing colon.
> > >
> > > ---
> > > diff -r 8441517e7e79 MAINTAINERS
> > > --- a/MAINTAINERS       Thu Jan  5 04:00:05 2006
> > > +++ b/MAINTAINERS       Wed Jan  4 13:49:27 2006
> > > @@ -681,7 +681,7 @@
> > >
> > >   DAC960 RAID CONTROLLER DRIVER
> > >   P:     Dave Olien
> > > -M      dmo@osdl.org
> > > +M:     dmo@osdl.org
> > >   W:     http://www.osdl.org/archive/dmo/DAC960
> > >   L:     linux-kernel@vger.kernel.org
> > >   S:     Maintained
> >
> > That would be helpful except that Dave is no longer at OSDL
> > and is no longer maintaining that driver...
> 
> I don't know who I should CC to this email but it seems it's time to
> update http://developer.osdl.org/dev/people/ since Dave is still
> listed as an OSDL developer.

That list has been fixed.  Thanks.

---
~Randy
