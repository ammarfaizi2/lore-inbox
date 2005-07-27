Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVG0KP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVG0KP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 06:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVG0KP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 06:15:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39649 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262174AbVG0KPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 06:15:51 -0400
Date: Wed, 27 Jul 2005 03:14:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
Message-Id: <20050727031449.00b05e20.akpm@osdl.org>
In-Reply-To: <20050727100815.GA22552@mars.ravnborg.org>
References: <20050727024330.78ee32c2.akpm@osdl.org>
	<20050727100815.GA22552@mars.ravnborg.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Jul 27, 2005 at 02:43:30AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm2/
> > 
> > 
> > - Lots of fixes and updates all over the place.  There are probably over 100
> >   patches here which need to go into 2.6.13.
> > 
> > - A reminder that -mm commit activity may be monitored by subscribing to
> >   the mm-commits list.  Do
> > 
> > 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
> Archived anywhere?

Not to my knowledge.

> Could not find it at marc.theaimsgroup.com. I will gladly ask them to
> add it though if you say so.

If you think it's useful, please.

>  
> > number of patches in -mm: 764
> > number of changesets in external trees: 9
> 
> There is a bit more than 9 changesets (or whatever it is called in the
> git world) in the .git trees you suck in.

yes, that script still expects bk diffs..
