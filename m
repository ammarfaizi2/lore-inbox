Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVDDTdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVDDTdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVDDTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:33:06 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:34663 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261349AbVDDTc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:32:57 -0400
X-ME-UUID: 20050404193255809.C5A691C0015A@mwinf0504.wanadoo.fr
Date: Mon, 4 Apr 2005 21:29:45 +0200
To: Greg KH <greg@kroah.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404192945.GB1829@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050404191745.GB12141@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 12:17:46PM -0700, Greg KH wrote:
> On Mon, Apr 04, 2005 at 08:27:53PM +0200, Sven Luther wrote:
> > Mmm, probably that 2001 discussion about the keyspan firmware, right ?
> > 
> >   http://lists.debian.org/debian-legal/2001/04/msg00145.html
> > 
> > Can you summarize the conclusion of the thread, or what you did get from it,
> > please ? 
> 
> That people didn't like the inclusion of firmware, I posted how you can
> fix it by moving it outside of the kernel, and asked for patches.

Yeah, that is a solution to it, and i also deplore that none has done the job
to make it loadable from userland. For now, debian is satisfied by moving the
whole modules involved to non-free, and this has already happened in part.

> None have come.
> 
> So I refuse to listen to talk about this, as obviously, no one cares
> enough about this to actually fix the issue.

Well, i disagree with the above analysis. The problem is not so much that the
firmware violate the GPL, as it constitutes mere agregation, but that the
actual copyright statement of the files containing the firmware blobs place
them de-facto under the GPL, which i doubt is what was intented originally,
don't you think.

And *I* do care about this issue, and will follow up this issue with mails to
the individual copyright holders of the file, to clarify the situation.

> People drag this up about once a year, so you are just following the
> trend...

Nope, i am aiming to clarify this issue with regard to the debian kernel, so
that we may be clear with ourselves, and actually ship something which is not
of dubious legal standing, and that we could get sued over for GPL violation.

> This is my last reply to this thread, unless it contains code.

Ok, but i hope that not only code, but patches clarifying the legal situation
will make you happy.

Friendly,

Sven Luther

