Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTK2CR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 21:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbTK2CR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 21:17:56 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:46016 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263605AbTK2CRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 21:17:54 -0500
Date: Sat, 29 Nov 2003 13:22:21 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129022221.GA516@gnu.org>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128142452.GA4737@win.tue.nl>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 03:24:52PM +0100, Andries Brouwer wrote:
> On Fri, Nov 28, 2003 at 10:28:54AM +0530, Apurva Mehta wrote:
> 
> > On 2.6.0-testx kernels, I have noticed that there are problems with
> > GNU Parted. Parted says that the disk geometries reported by the
> > kernel are incorrect.
> 
> Yes. Parted should be fixed not to complain.
> There is no such thing as a "correct" disk geometry.

Yes there is.  "Correct" is defined by the BIOS.  It is important
for boot loaders (in particular Windows).  I'm not sure if this
is still a big issue worth worrying about.

Cheers,
Andrew

