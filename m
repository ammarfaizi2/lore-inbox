Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTI3WKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTI3WKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:10:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:58323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261773AbTI3WKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:10:53 -0400
Date: Tue, 30 Sep 2003 15:10:46 -0700
From: Greg KH <greg@kroah.com>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6: a few __init bugs
Message-ID: <20030930221046.GA21000@kroah.com>
References: <1064872693.5733.42.camel@dooby.cs.berkeley.edu> <20030929221113.GB2720@kroah.com> <1064946634.5734.106.camel@dooby.cs.berkeley.edu> <20030930191117.GA20054@kroah.com> <1064956854.5733.233.camel@dooby.cs.berkeley.edu> <20030930212551.GA20709@kroah.com> <1064958129.5264.237.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064958129.5264.237.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 02:42:09PM -0700, Robert T. Johnson wrote:
> On Tue, 2003-09-30 at 14:25, Greg KH wrote:
> > Hm, good point.  Can you think of a better place for this that would
> > have helped you out?
> 
> Take two.  It might not have prevented me from reporting the potential
> bug, but I would've known you'd thought about it, it might help future
> developers, and it's unlikely to become dangerously wrong.  Thanks.

Thanks, I've applied this patch.

greg k-h
