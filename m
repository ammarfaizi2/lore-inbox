Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTJGTFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 15:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTJGTFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 15:05:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:21646 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262723AbTJGTFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 15:05:47 -0400
Date: Tue, 7 Oct 2003 12:05:31 -0700
From: Greg KH <greg@kroah.com>
To: "Jonathan A. George" <JAGeorge@greshamstorage.com>,
       linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Linux 2.6 udev capability question
Message-ID: <20031007190531.GM1956@kroah.com>
References: <3F830C49.5070103@greshamstorage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F830C49.5070103@greshamstorage.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 01:56:09PM -0500, Jonathan A. George wrote:
> Greg & Al,
> 
> Will the udev model somehow support the ability to associate a device 
> node with a specific device?
> 
> For example in a Fibre Channel, SCSI, iSCSI (SAN) date network 
> environment it would be nice to associate a specific device driver 
> handle per (WorldWideName and/or Type+Vendor+Model+Serial#).
> 
> It would also be nice to be able to associate via the LUN target path.
> 
> Obviously the same basic problem space applies to USB devices, and I 
> have admittedly not reviewed the specs for sysfs and udev in 2.6.  If 
> the answer to all of these questions is Yes+RTFM that would make me very 
> happy.  Otherwise I would be interested in knowing whether or not it is 
> even possible in the udev model, and if it is what would be the 
> recommended approach to implementation.

Yes, RTFM  :)

> P.S. Feel free to forward your response to LKML since there are no doubt 
> others with the same question in mind.

Will do.  Why did you not ask this there in the first place?  Sending
email directly to developers isn't the nicest thing to do:
	http://www.arm.linux.org.uk/news/?newsitem=11

thanks,

greg k-h
