Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVCFFIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVCFFIs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 00:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVCFFIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 00:08:47 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:14341 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S261313AbVCFFHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 00:07:41 -0500
Date: Sat, 5 Mar 2005 21:05:31 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050306050531.GB11889@kroah.com>
References: <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050304143614.203278fd.akpm@osdl.org> <20050305000604.GA3355@kroah.com> <Pine.LNX.4.58.0503041627340.11349@ppc970.osdl.org> <20050305075343.GA20513@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305075343.GA20513@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 02:53:43AM -0500, Dave Jones wrote:
> On Fri, Mar 04, 2005 at 04:28:02PM -0800, Linus Torvalds wrote:
>  > On Fri, 4 Mar 2005, Greg KH wrote:
>  > > On Fri, Mar 04, 2005 at 02:36:14PM -0800, Andrew Morton wrote:
>  > > > But we end up with a cset in the permanent kernel history which simply
>  > > > should not have been there.
>  > > 
>  > > Is this really a big deal?
>  > 
>  > Once? No. If it ends up being "par for the course", it's bad.
> 
> The amount of stuff in the sucker tree shouldn't really amount
> to /that/ many patches should it ? If it does, then 2.6.x is in
> worse shape than we've all been admitting.
> 
> Would it be that much work to just send the 'meat' as gnu patches,
> and leave the not-for-linus stuff alone ?

No it would not be, and should be the way this works.

thanks,

greg k-h
