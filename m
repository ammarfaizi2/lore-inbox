Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTLAVUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbTLAVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:20:25 -0500
Received: from web40911.mail.yahoo.com ([66.218.78.208]:56412 "HELO
	web40911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264233AbTLAVUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:20:18 -0500
Message-ID: <20031201212013.62049.qmail@web40911.mail.yahoo.com>
Date: Mon, 1 Dec 2003 13:20:13 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Clean up older Kernels
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031201205001.GA14720@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Garzik,

--- Jeff Garzik <jgarzik@pobox.com> wrote:
> On Mon, Dec 01, 2003 at 12:32:46PM -0800, Bradley Chapman wrote:
> > Mr. Garzik,
> > 
> > > > On Mon, Dec 01, 2003 at 08:40:47PM +0100, Thomas Babut wrote:
> > > > Hi,
> > > >
> > > > perhaps my question is unusual, but why do you not clean up the older Linux
> > > > Kernels?
> > > >
> > > > The Kernel 2.0.39 is the last stable one, but there is also a 2.0.40-rc6. So
> > > > why not releasing it as stable 2.0.40 (final)? And Alan Cox isn't active any
> > > > more for some time and the ac-Patches are very old. They could be removed,
> > > > or not?
> > >
> > > 2.0.x has a maintainer, David Winehall(sp?) IIRC. Poke him... :)
> > >
> > > I agree, might as well put out 2.0.40...
> > 
> > I've been wondering about this too, but I was afraid to ask first :-)
> > 
> > When 2.6 is officially released as a stable kernel and 2.4 is relegated to
> security/
> > bugfix-only status, what will happen to 2.0 and 2.2? Obviously, they won't be
> > totally ignored for support reasons (not everyone uses 2.4 - see
> counter.li.org),
> > but what will Mr. Anvin do to the frontpage of kernel.org?
> 
> I don't see there being any radical change...  Alan still puts out 2.2
> security fixes occasionally, and the older Linux kernels will _always_
> be archived on ftp.kernel.org.  They're not going away... :)

And they shouldn't -- there's no reason for them to disappear from the site.
I'm just wondering if Mr. Anvin will reorganize things so that the hierarchy
of kernels is: 2.6, 2.6-pre, 2.6-ac, 2.4, 2.4-pre, 2.2, 2.2-pre, 2.0, 2.0-pre.

Or will he leave things as they are?

Brad


=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
