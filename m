Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTDXOsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDXOsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:48:05 -0400
Received: from havoc.daloft.com ([64.213.145.173]:57535 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263720AbTDXOsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:48:03 -0400
Date: Thu, 24 Apr 2003 11:00:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Bradford <john@grabjohn.com>, Jamie Lokier <jamie@shareable.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424150012.GA5993@gtf.org>
References: <200304240816.h3O8GGrH000399@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.44.0304240741530.20549-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304240741530.20549-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 07:45:16AM -0700, Linus Torvalds wrote:
> On Thu, 24 Apr 2003, John Bradford wrote:
> > Incidently, using the Transmeta CPUs, is it not possible for the user
> > to replace the controlling software with their own code?  I.E. not
> > bother with X86 compatibility at all, but effectively design your own
> > CPU?  Couldn't we make the first Lin-PU this way?

> If open hardware is what you want, FPGA's are actually getting to the
> point where you can do real CPU's with them. They won't be gigahertz, and

Yep.  Check out http://www.opencores.org/   At least one CPU there
already can boot Linux.

I'm waiting for the day, in fact, when somebody will use the OpenCores
tech to build an entirely open system...  They seem to have most of the
pieces done already, though I dunno how applicable Wishbone technology
is to PC-like systems.

	Jeff



