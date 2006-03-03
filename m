Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWCCXkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWCCXkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWCCXkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:40:24 -0500
Received: from tomts25.bellnexxia.net ([209.226.175.188]:59818 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751046AbWCCXkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:40:24 -0500
Date: Fri, 3 Mar 2006 18:40:18 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
X-X-Sender: scottm@godzilla.spiteful.org
To: Greg KH <greg@kroah.com>
cc: Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
In-Reply-To: <20060303232739.GA11796@kroah.com>
Message-ID: <Pine.LNX.4.58.0603031836570.31840@godzilla.spiteful.org>
References: <9D653F4D-A375-4D2C-8A5A-063A0BBD962B@kernel.crashing.org>
 <20060303220741.GA22298@kroah.com> <A9483AAD-670C-4D03-9996-6AE89F6FD4FB@kernel.crashing.org>
 <20060303232739.GA11796@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006, Greg KH wrote:

> On Fri, Mar 03, 2006 at 05:13:55PM -0600, Kumar Gala wrote:
> > I found cpqhp_configure_device(), but I dont see anything about how  
> > to handle assigned a fixed address to the BAR.
> 
> I don't know either, try asking on the pci hotplug mailing list and CC:
> Scott, the author of that driver for how his devices work around that.

Heh, I'm the Compact PCI hotplug guy, not the Compaq PCI hotplug guy. :)

Scott


-- 
==============================================================================
Scott Murray, scott@spiteful.org

     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"
