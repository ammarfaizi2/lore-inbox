Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263098AbTCUAAj>; Thu, 20 Mar 2003 19:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263114AbTCUAAi>; Thu, 20 Mar 2003 19:00:38 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:63492 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S263098AbTCUAAd>; Thu, 20 Mar 2003 19:00:33 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303210013.h2L0D0jx000566@81-2-122-30.bradfords.org.uk>
Subject: Re: Release of 2.4.21
To: akpm@digeo.com (Andrew Morton)
Date: Fri, 21 Mar 2003 00:13:00 +0000 (GMT)
Cc: hch@infradead.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
In-Reply-To: <20030320175532.3ef85c1b.akpm@digeo.com> from "Andrew Morton" at Mar 20, 2003 05:55:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
> > > the 2.4.21-pre cycle, that would be less productive than just patching
> > > 2.4.20 and rolling a separate release off of that.
> > 
> > I think the naming is illogical.  If there's a bugfix-only release
> > it whould have normal incremental numbers.  So if marcelo want's
> > it he should clone a tree of at 2.4.20, apply the essential patches
> > and bump the version number in the normal 2.4 tree to 2.4.22-pre1
> 
> No point in making things too complex.  2.4.20-post1 is something people can
> easily understand.
> 
> I needed that for the ext3 problems which popped up shortly after 2.4.20 was
> released - I was reduced to asking people to download fixes from my web page.
> 
> And having a -post stream may allow us to be a bit more adventurous in the
> -pre stream.

Why can't we just make all releases smaller and more frequent?

Why do we need 2.4.x-pre at all, anyway - why can't we just test
things in the -[a-z][a-z] trees, and _start_ with -rc1?

Why can't we just do bugfixes for 2.4, and speed up 2.5 development?

John.
