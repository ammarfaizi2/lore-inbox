Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967776AbWK3BHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967776AbWK3BHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967779AbWK3BHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:07:47 -0500
Received: from xenotime.net ([66.160.160.81]:53210 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S967776AbWK3BHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:07:47 -0500
Date: Wed, 29 Nov 2006 17:08:15 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Greg Norris <haphazard@kc.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.19
Message-Id: <20061129170815.29d985c2.rdunlap@xenotime.net>
In-Reply-To: <20061130005631.GA3896@yggdrasil.localdomain>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
	<20061129151111.6bd440f9.rdunlap@xenotime.net>
	<20061130005631.GA3896@yggdrasil.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 18:56:31 -0600 Greg Norris wrote:

> On Wed, Nov 29, 2006 at 03:11:11PM -0800, Randy Dunlap wrote:
> > What would it take to have the kernel.org web page and finger banner
> > give the correct version information?  (yessir, not your problem)
> 
> On a similar vein, it'd be nice if http://www.kernel.org/kdist/version.html 
> would break the entries into separate lines.


I prefer to use
http://www.kernel.org/kdist/finger_banner
for that.  And script it so that I can just type:

$ kcurrent
to see it.

---
~Randy
