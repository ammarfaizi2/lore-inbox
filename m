Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290981AbSAaJIQ>; Thu, 31 Jan 2002 04:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290987AbSAaJIG>; Thu, 31 Jan 2002 04:08:06 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:18438 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S290981AbSAaJIA>; Thu, 31 Jan 2002 04:08:00 -0500
Date: Wed, 30 Jan 2002 23:09:54 +0000
To: linux-lvm@sistina.com, linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: [lvm-devel] [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020130230954.E7763@fib011235813.fsnet.co.uk>
In-Reply-To: <20020130202254.A7364@fib011235813.fsnet.co.uk> <20020130145408.I763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130145408.I763@lynx.adilger.int>; from adilger@turbolabs.com on Wed, Jan 30, 2002 at 02:54:08PM -0700
From: Joe Thornber <thornber@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:54:08PM -0700, Andreas Dilger wrote:
> On Jan 30, 2002  20:22 +0000, Joe Thornber wrote:
> > Sistina is pleased to announce that the LVM2 software is ready for
> > beta testing.
> > 
> > This is a complete reimplementation of the existing LVM system, both
> > driver and userland tools.
> 
> What is the current and future licensing of the LVM2 code?  Given the
> GFS events, I think people will be hesitant to accept an all-Sistina
> reimplementation of LVM.


LVM2 is GPL/LGPL-licensed - just like the original version of LVM.
This means the whole Linux community benefits from this aspect of
Sistina's work.  The device-mapper and LVM2 packages will *always* be
GPL/LGPL.

As those who have been following LVM development closely will be aware,
the decision to rewrite was taken for sound technical - not licensing -
reasons, and of course we welcome and encourage contributions to LVM2
from outside Sistina.

- Joe
