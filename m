Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264441AbUAHNIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUAHNIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:08:54 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:10207 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264441AbUAHNIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:08:52 -0500
Date: Thu, 8 Jan 2004 21:08:08 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <Pine.LNX.4.44.0401082026340.354-100000@donald.themaw.net>
Message-ID: <Pine.LNX.4.44.0401082106500.354-100000@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004, Ian Kent wrote:

Oh! This should have related to the comments about removing autofs from
the kernel.

Sorry about the confusion.

> On Wed, 7 Jan 2004, Mike Waychison wrote:
>
> >
> > This is a good example of why this stuff should probably be merged into
> > VFS,  autofs4 has yet to be updated to use this lock.  This comes with
> > the decision to a) no longer support it as a module, only built in, or
> > b) make vfsmount_lock accessible to modules.
>
> Please don't say it this way.
>
> A new implementation may mean current autofs becomes depricated but
> this is a deprecation process, not a slash and burn, and needs to be
> managed.
>


