Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVKVPgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVKVPgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKVPgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:36:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:51149 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964959AbVKVPgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:36:47 -0500
Date: Tue, 22 Nov 2005 10:36:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Gustavo Guillermo =?iso-8859-1?Q?P=E9rez?= 
	<gustavo@compunauta.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: /dev/sr0 not ready, but working
In-Reply-To: <20051121232531.GA24565@havoc.gtf.org>
Message-ID: <Pine.LNX.4.44L0.0511221034110.4786-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Jeff Garzik wrote:

> On Mon, Nov 21, 2005 at 04:00:51PM -0600, Gustavo Guillermo Pérez wrote:
> > When I use my external case as Firewire or USB 2.0 I got the error on the 
> > kernel syslog:
> > sr 0:0:0:0: Device not ready.
> > last message repeated 187 times
> > 
> > Same using amdtp FireWire Driver and usb-storage driver.
> > 
> > but the drive keeps writing and the media finish and close as espected on the 
> > 95% of times, the other 5% :(.
> 
> This happens on my S/ATAPI box too...	

What is an S/ATAPI box?

Would either of you like to tell us when these messages come up?  What are 
you doing with the drive?  Does it happen only when the drive is writing?  
What about when the drive is reading?  Does anything else of interest 
appear in the system log?

Alan Stern

