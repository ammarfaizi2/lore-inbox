Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbULURXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbULURXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 12:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbULURXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 12:23:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:23191 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261816AbULURUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 12:20:52 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add PCI API to sysfs
Date: Tue, 21 Dec 2004 09:20:22 -0800
User-Agent: KMail/1.7.1
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org,
       benh@kernel.crashing.org
References: <200412201450.47952.jbarnes@engr.sgi.com> <200412201501.12575.jbarnes@engr.sgi.com> <20041221170528.GB1459@kroah.com>
In-Reply-To: <20041221170528.GB1459@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412210920.22965.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 21, 2004 9:05 am, Greg KH wrote:
> On Mon, Dec 20, 2004 at 03:01:12PM -0800, Jesse Barnes wrote:
> > > What happens if mmap is not set?  oops...
> >
> > Yeah, I mentioned that in "things to do" at the bottom, but I'm really
> > looking for an "ack, this is a sane way to go" before I sink much more
> > time into it.
>
> I think this is a sane way to go.
>
> How about sending me a patch just to add the mmap support to binary
> sysfs files now?  I'll be glad to add that to my trees.
>
> Then you can work on the pci stuff over time.
>
> Sound good?

Sure, coming right up.

Thanks,
Jesse
