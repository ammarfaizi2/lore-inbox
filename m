Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTI3VZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTI3VZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:25:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:22217 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261705AbTI3VZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:25:56 -0400
Date: Tue, 30 Sep 2003 14:25:51 -0700
From: Greg KH <greg@kroah.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6: a few __init bugs
Message-ID: <20030930212551.GA20709@kroah.com>
References: <1064872693.5733.42.camel@dooby.cs.berkeley.edu> <20030929221113.GB2720@kroah.com> <1064946634.5734.106.camel@dooby.cs.berkeley.edu> <20030930191117.GA20054@kroah.com> <1064956854.5733.233.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064956854.5733.233.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:20:53PM -0700, Robert T. Johnson wrote:
> On Tue, 2003-09-30 at 12:11, Greg KH wrote:
> > Hm, care to send in a patch that adds a comment to that __init call so
> > that others don't make the same mistake in a year or so?
> 
> Here's the patch you requested, but I recommend against applying it
> since it's the sort of comment that can easily become wrong, leading to
> missed bugs in future kernels.  Thanks again for your help.

Hm, good point.  Can you think of a better place for this that would
have helped you out?

thanks,

greg k-h
