Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbTLIJ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbTLIJ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:27:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:37604 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266178AbTLIJ1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:27:49 -0500
Date: Tue, 9 Dec 2003 01:16:30 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Reppert <repp0017@tc.umn.edu>
Cc: Bob <recbo@nishanet.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       witukind@nsbm.kicks-ass.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031209091630.GA2753@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <3FD577E7.9040809@nishanet.com> <1070955596.25311.19.camel@minerva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070955596.25311.19.camel@minerva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 01:39:56AM -0600, Matthew Reppert wrote:
> 
> My guess is, unfortunately, udev probably won't handle this any time
> soon. (Or, if it does, through some possibly clever mechanism that, as
> someone unfamiliar with the relevant bits of the system, I can't see.)

udev will never handle it.  That's not its job.

> I'd be interested in a solution to this, mostly out of curiosity since
> it seems like it might be interesting, but I don't see a nice one coming
> easily. I wouldn't mind someone more clueful telling me I'm wrong,
> though. At the least, it means more people being receptive to moving
> to udev.

Solution for a problem that is non-existant on a properly configured
system?  Why?  :)


greg k-h
