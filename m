Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWBNTOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWBNTOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWBNTOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:14:08 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:29710 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422665AbWBNTOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:14:07 -0500
Date: Tue, 14 Feb 2006 20:14:02 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060214191402.GD51709@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com> <43F13BDF.3060208@cfl.rr.com> <DD0B9449-14AF-47D1-8372-DDC7E896DBC2@mac.com> <43F17850.8080600@cfl.rr.com> <F157E3C4-0D62-413C-B08B-91A567B8C09B@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F157E3C4-0D62-413C-B08B-91A567B8C09B@mac.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 11:23:53AM -0500, Kyle Moffett wrote:
> SCSI != USB.  Users generally don't expect to hotplug SCSI devices  
> while booted and running (with the exception of some _really_  
> expensive hotplug-bays where we expect the admin to know what the  
> hell they're doing).  On the other hand, users _do_ expect to hotplug  
> random USB devices whenever they feel like it.

I do expect to be able to move non-mounted disks around while
suspended to disk, whatever their kind is (ide, sata, scsi, whatever).
That's one of the main reasons you want a reliable suspend-to-disk on
servers, another one being riding predicted powerloss (moving boxes
around can be called a powerloss).

  OG.
