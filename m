Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVC0AsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVC0AsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 19:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVC0AsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 19:48:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:22953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261382AbVC0AsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 19:48:15 -0500
Date: Sat, 26 Mar 2005 16:48:02 -0800
From: Greg KH <greg@kroah.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327004801.GA610@kroah.com>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk> <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111869274.32641.0.camel@mindpipe>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 03:34:34PM -0500, Lee Revell wrote:
> On Sat, 2005-03-26 at 10:28 -0800, Greg KH wrote:
> > On Sat, Mar 26, 2005 at 05:52:20PM +0000, Mark Fortescue wrote:
> > > 
> > > I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
> > > I have found that I can't use SYSFS on Linux-2.6.10.
> > > 
> > > Why ?. 
> > 
> > What ever gave you the impression that it was legal to create a
> > "Proprietry" kernel driver for Linux in the first place.
> 
> The fact that Nvidia and ATI get away with it?

So, the fact that someone else is doing something illegal, makes it
acceptable for you to do the same thing?  Please, talk to a lawyer about
this issue if you have _any_ questions.

And, to paraphrase Larry McVoy, if you can't afford to consult a proper
IP lawyer, then your IP isn't worth risking.  Release it under the GPL
and you will have no problems.

thanks,

greg k-h
