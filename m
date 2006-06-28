Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWF1XOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWF1XOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWF1XOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:14:23 -0400
Received: from xenotime.net ([66.160.160.81]:44763 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751766AbWF1XOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:14:22 -0400
Date: Wed, 28 Jun 2006 16:17:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: wim@iguana.be, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [WATCHDOG] v2.6.17 watchdog patches
Message-Id: <20060628161707.a6e13fef.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0606281600300.12404@g5.osdl.org>
References: <20060628193145.GA2738@infomag.infomag.iguana.be>
	<Pine.LNX.4.64.0606281600300.12404@g5.osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 16:02:06 -0700 (PDT) Linus Torvalds wrote:

> 
> 
> On Wed, 28 Jun 2006, Wim Van Sebroeck wrote:
> > 
> > Please pull from 'master' branch of
> > 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
> > or if master.kernel.org hasn't synced up yet:
> > 	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
> 
> Btw, you're apparently not signing off on the patches as you apply them to 
> your tree.
> 
> It looks like the sequence up to you is properly signed off, but you 
> should close it off to make the committer field match the whole sign-off 
> chain:
> 
> > Author: Randy Dunlap <rdunlap@xenotime.net>
> > Date:   Sun May 21 20:58:10 2006 -0700
> > 
> >     [WATCHDOG] Documentation/watchdog update
> >     
> >     Documentation/watchdog/:
> >     Expose example and tool source files in the Documentation/ directory in
> >     their own files instead of being buried (almost hidden) in readme/txt files.
> >     
> >     This will make them more visible/usable to users who may need
> >     to use them, to developers who may need to test with them, and
> >     to janitors who would update them if they were more visible.
> >     
> >     Also, if any of these possibly should not be in the kernel tree at
> >     all, it will be clearer that they are here and we can discuss if
> >     they should be removed.
> >     
> >     Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> >     Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> It went from Randy to Win to Andrew and then to you, but your sign-off is 
> missing..

It's "Wim", not "Win".  He is listed in the middle above.
Is that the problem (middle location)?

---
~Randy
