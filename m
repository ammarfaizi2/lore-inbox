Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbTFSTQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbTFSTQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:16:36 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:4342 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265911AbTFSTQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:16:34 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Thorsten =?iso-8859-1?q?K=F6rner?= 
	<thorstenkoerner@123tkshop.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Troll Tech [was RE: Sco vs. IBM]
Date: Thu, 19 Jun 2003 14:30:02 -0500
X-Mailer: KMail [version 1.2]
References: <170EBA504C3AD511A3FE00508BB89A920234CD34@exnanycmbx4.ipc.com> <03061913583400.25866@tabby> <200306192108.13032.thorstenkoerner@123tkshop.org>
In-Reply-To: <200306192108.13032.thorstenkoerner@123tkshop.org>
MIME-Version: 1.0
Message-Id: <03061914300200.25966@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 June 2003 14:08, Thorsten Körner wrote:
> Hi Jesse
>
> Am Donnerstag, 19. Juni 2003 20:58 schrieb Jesse Pollard:
> > On Thursday 19 June 2003 12:37, Downing, Thomas wrote:
> > > I'm no authority, but IMHO
> > >
> > > > In article <20030619141443.GR29247@fs.tum.de>,
> > > >
> > > > Adrian Bunk  <bunk@fs.tum.de> wrote:
> >
> > [snip]
> >
> > > > Which makes no sense. You're not at the mercy of Linus or the
> > > > kernel developers, neither at that of the KDE developers, but
> > > > TrollTech controls the KDE desktop wrt commercial apps.
> > >
> > > No, they don't.  KDE uses the GPL for QT.  If I build a commercial
> > > app using KDE, it is GPL.  If I build a commercial app not using
> > > KDE, but using commercial QT, that has no effect on the KDE desktop.
> >
> > Lets see...
> >
> > SCO releases Linux code under GPL...
>
> Did they ?!? No they didn't
> They are talking about old Unix-Licenses, not about Linux. And SCO also has
> not licensed Unix to IBM themselves.

It was my understanding that you could download SCO Linux up until about a 
month after they started the lawsuit. By that time, all/most of the contested
code had to already be in the kernel. Since SCO was supplying it, it was 
released (my opinion).

IMHO IBM AIX doesn't owe anything to SCO. Sure in the early days, IBM did 
consider using System V... but it had so many problems being ported that they
completely dropped it, and continued with AIX development instead.

I've used both.. and believe me, AIX doesn't work ANYTHING like System V. no
virtualization (disks), no partitioning (systems), no distributed operations, 
minimal networking, no Power support... (this was a 202e prototype at the 
time I believe...

All of that belonged to AIX. which even had SMP beginnings (some platforms).
Even shared memory was not exactly working well on System V (semaphores were
very slow).
