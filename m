Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVBHFxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVBHFxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 00:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVBHFxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 00:53:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:10452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261470AbVBHFxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 00:53:05 -0500
Date: Mon, 7 Feb 2005 21:52:44 -0800
From: Greg KH <greg@kroah.com>
To: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
Cc: "Haigh, Mark" <mhaigh@spirentcom.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3-bk4] arch/i386/kernel/pci/irq.c:  Wrong message output
Message-ID: <20050208055244.GA31392@kroah.com>
References: <20050208053441.GA31216@suse.de> <4208512A.2050905@spirentcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4208512A.2050905@spirentcom.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 09:42:02PM -0800, Mark F. Haigh wrote:
> Greg KH wrote:
> >On Mon, Feb 07, 2005 at 09:06:18PM -0800, Mark F. Haigh wrote:
> <snip>
> > > --- arch/i386/pci/irq.c.orig  2005-02-07 20:40:58.140856536 -0800
> > > +++ arch/i386/pci/irq.c       2005-02-07 20:46:06.713946296 -0800
> >
> >Can you resend this so it can be applied with -p1 to patch, and a
> >Signed-off-by: line?
> >
> 
> Ack, my fault.
> 
> Mark F. Haigh
> Mark.Haigh@spirentcom.com
> 
> 
> Signed-off-by: Mark F. Haigh  <Mark.Haigh@spirentcom.com>

Oops, this time you forgot the whole description of the patch :(

Third time's the charm...

greg k-h
