Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWHaDAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWHaDAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 23:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWHaDAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 23:00:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751399AbWHaDAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 23:00:54 -0400
Date: Wed, 30 Aug 2006 20:00:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: piet@bluelane.com
Cc: vgoyal@in.ibm.com, George Anzinger <george@wildturkeyranch.net>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Subhachandra Chandra <schandra@bluelane.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How about an enumerated list of issues with the existing kgdb
 patches?
Message-Id: <20060830200020.cd5bb3d7.akpm@osdl.org>
In-Reply-To: <1156992153.24314.24.camel@piet2.bluelane.com>
References: <44EC8CA5.789286A@redhat.com>
	<20060824111259.GB22145@in.ibm.com>
	<44EDA676.37F12263@redhat.com>
	<1156966522.29300.67.camel@piet2.bluelane.com>
	<20060830204032.GD30392@in.ibm.com>
	<1156974093.29300.103.camel@piet2.bluelane.com>
	<20060830144822.3b8ffb9a.akpm@osdl.org>
	<20060830155710.5865faa0.akpm@osdl.org>
	<1156992153.24314.24.camel@piet2.bluelane.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 19:42:32 -0700
Piet Delaney <piet@bluelane.com> wrote:

> On Wed, 2006-08-30 at 15:57 -0700, Andrew Morton wrote:
> > On Wed, 30 Aug 2006 14:48:22 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > >  Plus: I'd want to see a maintainance person or team who
> > > respond promptly to email and who remain reasonably engaged with what's
> > > going on in the mainline kernel.  Because if problems crop up (and they
> > > will), I don't want to have to be the bunny who has to worry about them...
> > 
> > umm, clarification needed here.
> > 
> > No criticism of the present maintainers intended!  Last time I grabbed the
> > kgdb patches from sf.net they applied nicely, worked quite reliably (much
> > better than the old ones I'd been trying to sustain) and had been
> > tremendously cleaned up.
> 
> So why did you stop including them in the mm patch?

Some change in 2.6.17-pre caused it to all stop working.

> I recall your quality issue and Tom was all in favor
> of resolving them. Was it too much work cleaning up the 
> patches to meet your needs that lead to the patch being
> dropped from the mm series?

It all seems reasonably clean now, but I haven't looked closely (nor have I
had to)

> kgdb over ethernet is working great, and it looks like there
> is plenty of support on the SF mailing list.  

good.

> > 
> > It's a big step.
> 
> How about a concrete list of patch quality issues that the group
> can address to allow your weekly addition to the mm patch as a 
> set toward eventually integration.

>From whom?  me?

> Wouldn't getting kgdb back into the mm patch series be a reasonable
> first step eventual maintenance in kernel.org?

Is on my todo list somewhere.
