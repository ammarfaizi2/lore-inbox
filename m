Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVAVBIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVAVBIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVAVBIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:08:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:36058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262630AbVAVBIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:08:09 -0500
Date: Fri, 21 Jan 2005 17:08:05 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <dev@osdl.org>,
       <ltp-list@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <stp-devel@lists.sourceforge.net>
Subject: Re: [Dev] Re: Kernel Panic with LTP on 2.6.11-rc1 (was Re: LTP
 Results for 2.6.x and 2.4.x)
In-Reply-To: <20050121153308.I24171@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0501211706430.32650-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Bryce Harrington <bryce@osdl.org> wrote:
> > I am unable to find the oops trace amongst all that stuff.  Help?
> >
> > (It would have been handy to include it in the bug report, actually)
>
> Yes, it would.  Or at least some better granularity leading up to the
> problem.  I ran growfiles locally on 2.6.11-rc-bk and didn't have any
> problem.  Could you strace growfiles and see what it was doing when it
> killed the machine?

Okay, I'll set up another run and try collecting that info.  Is there
any other data that would be useful to collect while I'm at it?

Bryce

