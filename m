Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVCIQjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVCIQjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVCIQjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:39:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:17804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261636AbVCIQh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:37:56 -0500
Date: Wed, 9 Mar 2005 08:37:48 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       khali@linux-fr.org
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
Message-ID: <20050309163748.GD25079@kroah.com>
References: <20050308233743.GB11454@kroah.com> <Pine.LNX.3.96.1050309110218.3298A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1050309110218.3298A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 11:06:15AM -0500, Bill Davidsen wrote:
> On Tue, 8 Mar 2005, Greg KH wrote:
> 
> > On Tue, Mar 08, 2005 at 05:18:16PM -0500, Bill Davidsen wrote:
> > > Greg KH wrote:
> > > >ChangeSet 1.1998.11.27, 2005/02/25 15:48:28-08:00, khali@linux-fr.org
> > > >
> > > >[PATCH] PCI: One more Asus SMBus quirk
> > > >
> > > >One more Asus laptop requiring the SMBus quirk (W1N model).
> > > >
> > > >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > 
> > > Hopefully this and the double-free patch will be included in 2.6.11.n+1? 
> > 
> > what double-free patch?
> 
> ChangeSet 1.1998.11.26, 2005/02/25 15:48:12-08:00
> 
> See <11099696383203@kroah.com>.

Giving just the Subject: would have been easier to find the patch...

> Or do you feel the possible results are harmless enough to wait for the
> next release? Your call, obviously.

I'll add it to the -stable queue, thanks for pointing it out.

greg k-h
