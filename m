Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVAYRnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVAYRnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVAYRnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:43:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:53427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262032AbVAYRnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:43:40 -0500
Date: Tue, 25 Jan 2005 09:43:32 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: <chrisw@osdl.org>, <rddunlap@osdl.org>, <dev@osdl.org>,
       <stp-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <hanrahat@osdl.org>
Subject: Re: [torvalds@osdl.org: Re: Memory leak in 2.6.11-rc1?]
In-Reply-To: <20050124231828.0e369d7c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.33.0501250938540.11739-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, Andrew Morton wrote:
> Bryce Harrington <bryce@osdl.org> wrote:
> >
> > There is a new behavior, though.  Now the test is hanging indefinitely
> >  on the nptl01 test.  I am assuming that since it passed the spot that it
> >  had failed before, that this is an unrelated issue.
>
> I'm finding that nptl01 somtimes gets stuck and sometimes works OK.  Try
> running it by hand a few times.
>
> It could be an application bug or a kernel bug.

Okay, so it doesn't sound like anything to be worried about.

Thanks,
Bryce

