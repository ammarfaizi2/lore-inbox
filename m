Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVBIPvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVBIPvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 10:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVBIPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 10:51:22 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:21638 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261838AbVBIPvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 10:51:15 -0500
Date: Wed, 9 Feb 2005 07:51:13 -0800
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Stelian Pop <stelian@popies.net>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050209155113.GA10659@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Alexandre Oliva <aoliva@redhat.com>,
	Stelian Pop <stelian@popies.net>,
	Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
References: <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet> <20050204201157.GN27707@bitmover.com> <20050204214015.GF5028@deep-space-9.dsnet> <20050204233153.GA28731@electric-eye.fr.zoreil.com> <20050205193848.GH5028@deep-space-9.dsnet> <20050205233841.GA20875@bitmover.com> <20050208154343.GH3537@crusoe.alcove-fr> <20050208155845.GB14505@bitmover.com> <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 05:06:02AM -0200, Alexandre Oliva wrote:
> So you've somehow managed to trick most kernel developers into
> granting you power over not only the BK history

It's exactly the same as a file system.  If you put some files into a
file system does the file system creator owe you the knowledge of how
those files are maintained in the file system?  Since when is that part
of the deal?  Does that mean that I can insist you provide me with a
detailed specification, without an attached GPL, of how GCC works so I
can clone the technology into my commercial compiler?  

It's the same with any software package.  I know Red Hat uses Oracle,
why aren't you telling Oracle to disclose how Oracle works inside?
Is it possible that Red Hat signed a license agreement that prevents
them from accessing that information?  You bet it is.  Did Oracle trick
Red Hat into agreeing to this awful arrangement?  No, they spelled it
out in their license and Red Hat signed it.

What's going on here is no different than Red Hat deciding they don't
want to pay for Oracle so they are reverse engineering Oracle and
transferring the technology into MySQL.  

> I'd much rather you didn't ``give´´ it at all, then people wouldn't be
> locked into it, and the community might have come up with something as
> efficient earlier with the extra push.  

We're the only vendor I've ever heard of who provides a mirror of
the data in a competing free product.  Does Oracle do that for you?
Of course not.  But somehow we are the bad guys locking you in?  OK, if
your position is that we are locking you in then you'd have no problem
if we dropped the CVS gateway, that's of no value to you, right?  And we
rate limit the web interface so you can't get your patches without BK,
that's of no value either, right?

> > I don't come here every month and ask for the GPL to be removed from
> > some driver, that's essentially what you are doing
> 
> I don't think so.  What he's doing is more along the lines of `hey,
> this allegedly-GPLed driver contains a piece of binary firmware whose
> source code is not there, could we either replace it with actual GPLed
> code or remove the driver?

You are missing the point that there are two licenses.  Roman is trying
to tell us to change our license.  The point you missed was that that's
the same as me telling you to change the GPL for my benefit.  
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
