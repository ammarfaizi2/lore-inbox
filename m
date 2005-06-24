Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263008AbVFXPXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbVFXPXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbVFXPXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:23:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:31707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263008AbVFXPXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:23:32 -0400
Date: Fri, 24 Jun 2005 08:20:17 -0700
From: Greg KH <greg@kroah.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050624152016.GA29955@kroah.com>
References: <20050624081808.GA26174@kroah.com> <Pine.LNX.4.58.0506241113460.17615@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506241113460.17615@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 11:17:02AM -0400, Steven Rostedt wrote:
> > +/* uncomment to get debug messages */
> > +#define DEBUG
> > +
> 
> Don't you mean here "comment to turn off debug messages?" :-)

Well, I should have commented out that first, the comment is right, the
code is wrong :)

thanks,

greg k-h
