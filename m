Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTIDBuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbTIDBuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:50:15 -0400
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([66.93.172.17]:210 "EHLO
	nevyn.them.org") by vger.kernel.org with ESMTP id S264504AbTIDBuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:50:09 -0400
Date: Wed, 3 Sep 2003 21:50:06 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Reza Naima <reza@reza.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gdb-5.3 doesn't work under linux-2.6.0-test4 / ide unhandled interrupts
Message-ID: <20030904015006.GA28467@nevyn.them.org>
Mail-Followup-To: Reza Naima <reza@reza.net>, linux-kernel@vger.kernel.org
References: <20030902081222.GA22989@boom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902081222.GA22989@boom.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 01:12:22AM -0700, Reza Naima wrote:
> I've found no mention of this problem while searching the linux-kernel
> or the gdb archives...
> 
> In trying to debug a userland application (mythfrontend from
> mythtv.org) running on linux-2.6.0-test4, I get this as soon as the
> application tries to display video:
> 
> 	Program terminated with signal SIGTRAP, Trace/breakpoint trap.
> 	The program no longer exists.
> 	(gdb)
> 
> Running in the exact same environment but under linux-2.4.22, gdb works
> without fault and no problems occur.  The application also runs without
> problem under linux-2.6.0-test4 if gdb is not used.
> 
> I'm including my 2.6.0 dmesg output in case it might be useful.   Let me know
> if anyone wants additional information.  And again, I hope this is not
> off-topic.

I'm doing GDB development on top of 2.6.0-test4, and I haven't
encountered anything like this.  Sorry.  Does it work on other
programs?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
