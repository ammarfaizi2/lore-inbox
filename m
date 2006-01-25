Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWAYMUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWAYMUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 07:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWAYMUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 07:20:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55441 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751137AbWAYMUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 07:20:46 -0500
Date: Wed, 25 Jan 2006 13:20:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060125122035.GB1900@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <200601250035.39383.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601250035.39383.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 25-01-06 00:35:38, Rafael J. Wysocki wrote:
> Hi,
> 
> On Tuesday, 24 January 2006 22:13, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Hi,
> > > 
> > > This patch introduces a user space interface for swsusp.
> > 
> > How will we know if/when this feature is ready for mainline?  What criteria
> > can we use to judge that?
> 
> I think when we are able to demonstrate that it allows us to do more than
> the current built-in swsusp in terms of performance, security etc.  Of course
> we'll need some userland utilities for this purpose.
> 
> > Will you be developing and long-term maintaining the userspace tools?
> 
> Yes.
> 
> > Is it your expectation/hope that distros will migrate onto using them?  etc.
> 
> I think they'll find the interface useful.  I've been using it for a couple of
> weeks now and it really allowed me to do some tricks that are just impossible
> with the current implementation.

Interesting... what tricks? Where is the latest code? [On a related
note, I should probably give you suspend.sf.net account. Do you
already have login on sourceforge?]
								Pavel
-- 
Thanks, Sharp!
