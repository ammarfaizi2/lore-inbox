Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVEMDmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVEMDmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 23:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVEMDmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 23:42:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:715 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262226AbVEMDmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 23:42:09 -0400
Date: Thu, 12 May 2005 20:42:01 -0700
From: Greg KH <greg@kroah.com>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>, jbohac@suse.cz,
       jbenc@suse.cz
Subject: Re: ipw2100: intrusive cleanups, working this time ;-)
Message-ID: <20050513034201.GA11817@kroah.com>
References: <20050512225026.GA2822@elf.ucw.cz> <4283FA4D.3010208@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4283FA4D.3010208@linux.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 07:52:29PM -0500, James Ketrenos wrote:
> 
> Part of the process we have in place is to try and make sure that the
> versions that get picked up by distros and the majority of users have a
> 'known' level of quality.  As part of that, we only want to get changes
> pushed to -mm and eventual mainline that have gone through regression
> testing.

Any chance of making those regression tests public so we can all do this
kind of testing on any future changes that might be made to the driver?

Remember, once it hits mainline, lots of different people will be
touching it for various reasons at times...

thanks,

greg k-h
