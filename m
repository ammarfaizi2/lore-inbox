Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVCJQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVCJQzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVCJQvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:51:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:33183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262746AbVCJQtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:49:02 -0500
Date: Thu, 10 Mar 2005 08:36:47 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       khali@linux-fr.org
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
Message-ID: <20050310163647.GA16126@kroah.com>
References: <20050309163748.GD25079@kroah.com> <Pine.LNX.3.96.1050310065153.10287C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1050310065153.10287C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 06:54:57AM -0500, Bill Davidsen wrote:
> On Wed, 9 Mar 2005, Greg KH wrote:
> 
> > On Wed, Mar 09, 2005 at 11:06:15AM -0500, Bill Davidsen wrote:
> > > On Tue, 8 Mar 2005, Greg KH wrote:
> > > 
> > > > On Tue, Mar 08, 2005 at 05:18:16PM -0500, Bill Davidsen wrote:
> > > > > Greg KH wrote:
> > > > > >ChangeSet 1.1998.11.27, 2005/02/25 15:48:28-08:00, khali@linux-fr.org
> > > > > >
> > > > > >[PATCH] PCI: One more Asus SMBus quirk
> > > > > >
> > > > > >One more Asus laptop requiring the SMBus quirk (W1N model).
> > > > > >
> > > > > >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > > > >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > > > 
> > > > > Hopefully this and the double-free patch will be included in 2.6.11.n+1? 
> > > > 
> > > > what double-free patch?
> > > 
> > > ChangeSet 1.1998.11.26, 2005/02/25 15:48:12-08:00
> > > 
> > > See <11099696383203@kroah.com>.
> > 
> > Giving just the Subject: would have been easier to find the patch...
> 
> But... but... but it was YOUR PATCH, wasn't it? That's kind of why I
> didn't expect much problem identifying it, I got it from you.

No, I didn't write it.  If you notice, I sent out over 200 patches in
the past few days, the majority from other people.  So trying to
remember exactly which patch you were referring to took a bit of
searching :)

thanks,

greg k-h
