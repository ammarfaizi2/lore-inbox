Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266483AbUA2Wy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUA2Wv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:51:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:4767 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266483AbUA2WuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:50:16 -0500
Date: Thu, 29 Jan 2004 14:46:02 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_get_slot()
Message-ID: <20040129224602.GB9906@kroah.com>
References: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk> <20031218002444.GI6258@kroah.com> <20031218200031.GK15674@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218200031.GK15674@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 08:00:31PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 17, 2003 at 04:24:44PM -0800, Greg KH wrote:
> > I've applied the pci portions of this patch to my trees and will send it
> > on after 2.6.0 is out.
> 
> James Bottomley found a bug in it; could you also apply:

Thanks, I've applied this too.

greg k-h
