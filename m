Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVC2H1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVC2H1X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVC2H0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:26:21 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:38330 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262500AbVC2HMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:12:25 -0500
Date: Tue, 29 Mar 2005 02:12:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: claw network device driver
Message-ID: <20050329071210.GA16409@havoc.gtf.org>
References: <200503290533.j2T5XEYT028850@hera.kernel.org> <4248FBFD.5000809@pobox.com> <20050328230830.5e90396f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050328230830.5e90396f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 11:08:30PM -0800, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > Linux Kernel Mailing List wrote:
> >  > ChangeSet 1.2231.1.122, 2005/03/28 19:50:29-08:00, richtera@us.ibm.com
> >  > 
> >  > 	[PATCH] s390: claw network device driver
> >  > 	
> >  > 	Add support for claw network devices.
> >  > 	
> >  > 	Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >  > 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> >  > 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> > 
> >  Grumpity grump grump grump.  How tough is it to send new net drivers to 
> >  netdev and me for review?
> 
> Was cc'ed to linux-net last Thursday, but it looks like the messages was
> too large and the vger server munched it.

This also brings up a larger question... why was a completely unreviewed
net driver merged?

	Jeff



