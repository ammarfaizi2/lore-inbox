Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVCGGKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVCGGKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCGGKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:10:32 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:11 "EHLO vlinkmail")
	by vger.kernel.org with ESMTP id S261636AbVCGGKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:10:25 -0500
Date: Sat, 5 Mar 2005 22:55:55 -0800
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [BK PATCH] I2C patches for 2.6.11
Message-ID: <20050306065555.GD14943@kroah.com>
References: <20050304203531.GA31644@kroah.com> <20050305125902.71286764.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305125902.71286764.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 12:59:02PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> > Here is a I2C update for 2.6.11.  It includes a number of fixes, and
> > some new i2c drivers.  All of these patches have been in the past few
> > -mm releases.
> 
> I checked against my own list of patches and found that I have two more,
> which were posted to the sensors and kernel-janitors list in early
> february:
> http://archives.andrew.net.au/lm-sensors/msg29340.html
> http://archives.andrew.net.au/lm-sensors/msg29342.html
> 
> They never made it to your own i2c tree, nor Andrew's tree. What do we
> want to do with these?

They should show up in the -kj tree, right?  That will make it to the
-mm tree, and then the kernel janitor maintainer will split them up and
send them to me and you.

Or Nish can get frustrated at how long the whole process is taking, and
just resend them again :)

thanks,

greg k-h
