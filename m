Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVA2AAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVA2AAR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 19:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVA2AAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 19:00:16 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:56754 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262823AbVA2AAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 19:00:09 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: jdike@addtoit.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/10] UML - compile fixes
Date: Sat, 29 Jan 2005 00:59:50 +0100
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200501170556.j0H5uCkY006062@ccure.user-mode-linux.org> <200501281827.14366.blaisorblade@yahoo.it> <20050128141028.1586e7a9.akpm@osdl.org>
In-Reply-To: <20050128141028.1586e7a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501290059.51646.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 January 2005 23:10, Andrew Morton wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Monday 17 January 2005 08:27, Andrew Morton wrote:
> > > Jeff Dike <jdike@addtoit.com> wrote:
> > > > This fixes some warnings, and changes the system call table so that
> > > > it will compile in -linus, where the vperf system calls are not yet
> > > > merged.
> > >
> > > methinks we already fixed this.
> > >
> > > > Signed-off-by: Jeff Dike <jdike@addtoit.com>
> >
> > No, incorrect, this is not applied, current bitkeeper snapshots don't
> > compile for this reason too.
> >
> > Jeff, I think you should resend the patch anyway.
>
> I don't know what this is about.
Yes, it was from some days ago... so I guess either I or Jeff will have to 
resend it...

Andrew, when do you plan to release 2.6.11?

Jeff, you should send your queued fixes, and also resend this one (indeed, it 
was not applied). If I find the time I'll select the interesting ones and 
send them (with a mail to request their prompt merge).

> The only UML patch I have pending is 
>
> uml-kconfig_arch-little-cleanup-to-merge-before-2611.patch
Ok, please merge it ASAP (as the title suggests).

> From: blaisorblade@yahoo.it



-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
