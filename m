Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUHOGeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUHOGeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 02:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUHOGeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 02:34:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:36323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266507AbUHOGeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 02:34:17 -0400
Date: Sat, 14 Aug 2004 23:33:19 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, dsaxena@plexity.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040815063318.GA1787@kroah.com>
References: <20040811224117.GA6450@plexity.net> <20040811231314.GA32106@redhat.com> <20040811234245.GA7721@plexity.net> <20040811235929.GB32468@redhat.com> <20040814231153.24a4f8e7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814231153.24a4f8e7.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 11:11:53PM -0700, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> >  > My understanding is that goal is to 
> >   > make /proc slowly return to it's original purpose (process-information) 
> >   > and move other data out into sysfs.  
> > 
> >  I don't think thats a realistic goal.
> 
> It may be realistic if we try hard enough, but I don't think it's a
> desirable one at this time.  I'd prefer that I, Deepak and everyone else be
> spending cycles on higher-priority things than these patches.  Sorry.

But things like this are fun to do at times :)

Anyway, that being said, I'm going to keep Deepak's patches around in my
personal trees and see how well they work out as they are something that
I've personally been interested in doing for quite some time.  If, after
a while, things look better, I'll ask for a trial time in the -mm tree
for them.

thanks,

greg k-h

