Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTDVJrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTDVJrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:47:12 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:9741 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP id S263033AbTDVJrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:47:10 -0400
Date: Tue, 22 Apr 2003 02:56:35 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: What's the deal McNeil? Bad interactive behavior in X w/ RH's 2.4.18
Message-ID: <20030422095635.GR16934@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030422034821.6a57acc0.mba2000@ioplex.com> <200304221006.09601.m.c.p@wolk-project.de> <38291.207.172.171.44.1051004102.squirrel@miallen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38291.207.172.171.44.1051004102.squirrel@miallen.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 05:35:02AM -0400, Michael B Allen wrote:
> > On Tuesday 22 April 2003 09:48, Michael B Allen wrote:
> >
> > Hi Michael,
> >
> >> I'm running Red Hat 7.3 with their stock 2.4.18-3 kernel on an IBM
> >> T30. Once every few hours X locks up for 5-10 seconds while the disk
> >> grinds. If I type in an Xterm the characters are not echoed until the
> <snip>
> >> I would like very much for this behavior to go away as it is extremely
> >> annoying. If there is a patch please let me know where I can get it.
> > There are some hacks. One by Andrea Arcangeli, one by Neil Schemenauer and
> > one
> > by Con Kolivas and me. Search the archives please (lowlat elevator/io
> > scheduler)
> 
> Ok, I searched a little using the Googler at indiana.edu's archives but
> nothing jumped up and bit me. I'm not too excited about applying a patch
> snarfed out of an e-mail anywat.

That's how Linus, Marcello and everyone else gets them.

> I'm surprised no one else has not
> complained about this enough to the point where you guys don't have a
> canned answer with a link. Is this problem not considered important?
> 
> Does anyone know which RH patch in the 2.4.18-10 RPM adds this elevator
> throughput "improvement"? What identifiers would such a patch have in it?
> 
> Thanks,
> Mike
> 
> PS: Why are there only "hacks"? Is this not considered important?

It is up to Red Hat to $upply fixes for their kernels.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
