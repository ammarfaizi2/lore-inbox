Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVCIQT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVCIQT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCIQT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:19:26 -0500
Received: from mail.tmr.com ([216.238.38.203]:49932 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262035AbVCIQSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:18:00 -0500
Date: Wed, 9 Mar 2005 11:06:15 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       khali@linux-fr.org
Subject: Re: [PATCH] PCI: One more Asus SMBus quirk
In-Reply-To: <20050308233743.GB11454@kroah.com>
Message-ID: <Pine.LNX.3.96.1050309110218.3298A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Greg KH wrote:

> On Tue, Mar 08, 2005 at 05:18:16PM -0500, Bill Davidsen wrote:
> > Greg KH wrote:
> > >ChangeSet 1.1998.11.27, 2005/02/25 15:48:28-08:00, khali@linux-fr.org
> > >
> > >[PATCH] PCI: One more Asus SMBus quirk
> > >
> > >One more Asus laptop requiring the SMBus quirk (W1N model).
> > >
> > >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > >Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > Hopefully this and the double-free patch will be included in 2.6.11.n+1? 
> 
> what double-free patch?

ChangeSet 1.1998.11.26, 2005/02/25 15:48:12-08:00

See <11099696383203@kroah.com>.

Or do you feel the possible results are harmless enough to wait for the
next release? Your call, obviously.


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

