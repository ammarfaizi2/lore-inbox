Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbULRDA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbULRDA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 22:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbULRDA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 22:00:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:4542 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262820AbULRDAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 22:00:15 -0500
Date: Fri, 17 Dec 2004 18:57:59 -0800
From: Greg KH <greg@kroah.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs for 2.6.10-rc3
Message-ID: <20041218025759.GA27152@kroah.com>
References: <20041216213645.GA9710@kroah.com> <20041218023335.GA19699@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041218023335.GA19699@thunk.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 09:33:35PM -0500, Theodore Ts'o wrote:
> On Thu, Dec 16, 2004 at 01:36:45PM -0800, Greg KH wrote:
> > I've added debugfs to my bk driver tree (located at
> > bk://kernel.bkbits.net/gregkh/linux/driver-2.6) so it will show up in
> > the next -mm release.  
> 
> Debugfs is a very natural name, but it will undoubtedly cause
> confusion since we already have debugfs(8) in e2fsprogs.  One is a
> filesystem, and the other is a user-mode command, so it's not a total
> name collision, but it could cause some communication mixups.  
> 
> On the other hand, I couldn't think of a better name, so perhaps we
> should just live with it.  I did want to point out the potential
> problem now while there's still a chance to change it, though....

I agree about the name clash (I pointed it out in my original debugfs
post) and like you, I couldn't think of a better name either.

Think of it like a trademark, they both have the same name, yet they
live in different locations, hence they are both allowed to exist :)

thanks,

greg k-h
