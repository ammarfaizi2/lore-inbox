Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVCJMGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVCJMGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCJMGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:06:51 -0500
Received: from mail.tmr.com ([216.238.38.203]:62223 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262537AbVCJMGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:06:38 -0500
Date: Thu, 10 Mar 2005 06:54:57 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       khali@linux-fr.org
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
In-Reply-To: <20050309163748.GD25079@kroah.com>
Message-ID: <Pine.LNX.3.96.1050310065153.10287C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Greg KH wrote:

> On Wed, Mar 09, 2005 at 11:06:15AM -0500, Bill Davidsen wrote:
> > On Tue, 8 Mar 2005, Greg KH wrote:
> > 
> > > On Tue, Mar 08, 2005 at 05:18:16PM -0500, Bill Davidsen wrote:
> > > > Greg KH wrote:
> > > > >ChangeSet 1.1998.11.27, 2005/02/25 15:48:28-08:00, khali@linux-fr.org
> > > > >
> > > > >[PATCH] PCI: One more Asus SMBus quirk
> > > > >
> > > > >One more Asus laptop requiring the SMBus quirk (W1N model).
> > > > >
> > > > >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > > >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > > 
> > > > Hopefully this and the double-free patch will be included in 2.6.11.n+1? 
> > > 
> > > what double-free patch?
> > 
> > ChangeSet 1.1998.11.26, 2005/02/25 15:48:12-08:00
> > 
> > See <11099696383203@kroah.com>.
> 
> Giving just the Subject: would have been easier to find the patch...

But... but... but it was YOUR PATCH, wasn't it? That's kind of why I
didn't expect much problem identifying it, I got it from you.
> 
> > Or do you feel the possible results are harmless enough to wait for the
> > next release? Your call, obviously.
> 
> I'll add it to the -stable queue, thanks for pointing it out.

Great, then I didn't waste your time with it. I'm still feeling out what's
worth suggesting for -stable, as you probably guessed.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

