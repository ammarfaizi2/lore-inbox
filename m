Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUFPWsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUFPWsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUFPWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:48:09 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:2833 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264271AbUFPWqz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:46:55 -0400
Date: Thu, 17 Jun 2004 00:49:49 +0200
To: Erik Harrison <erikharrison@gmail.com>
Cc: davids@webmaster.com, eric@cisu.net, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
Message-ID: <20040616224949.GB7932@hh.idb.hist.no>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMKAA.davids@webmaster.com> <5b18a542040616133415bf54d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b18a542040616133415bf54d1@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 04:34:25PM -0400, Erik Harrison wrote:
> On Tue, 15 Jun 2004 21:11:00 -0700, David Schwartz <davids@webmaster.com> wrote:
> > 
> > 
> > > >     Permission is hereby granted for the distribution of this firmware
> > > >     image as part of a Linux or other Open Source operating
> > > >   system kernel
> > > >     in text or binary form as required.
> > 
> >        They can't grant that permission. Every single person who had contributed
> > to the Linux kernel would have to agree. The GPL prohibits including
> > software that isn't itself GPL'd from being combined with GPL'd software.
> > The issue is not permission to distribute this driver, the issue is
> > permission to distribute the *kernel*. The kernel's license prohibits
> > distrubiting it in combination with works that have licenses more
> > restrictive than the GPL.
> 
> That better be bogus, or else vendors are going to be very upset that
> they can't ship the kernel with, say, trademarked images. For example,
> Mozilla's trademark on their artwork is fairly restrictive, or the
> Mandrake Firewall product (if that's even still around - I don't keep
> up).

Not bogus, but the solutions are simple:

1. don't _link_ the proprietary file into the kernel, ship firmware & logo
as separate files along with the distro.  No problem.

2. Release drivers under the GPL instead of restrictive licence,
provide GPL'ed logos instead of the trademarked ones.

Helge Hafting
