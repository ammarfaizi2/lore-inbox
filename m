Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTLUNf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 08:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTLUNf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 08:35:26 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:41440 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262882AbTLUNfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 08:35:21 -0500
Date: Sun, 21 Dec 2003 08:35:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jamie Lokier <jamie@shareable.org>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
In-Reply-To: <20031221105333.GC3438@mail.shareable.org>
Message-ID: <Xine.LNX.4.44.0312210833030.3044-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003, Jamie Lokier wrote:

> Albert Cahalan wrote:
> > What about the obvious Kconfig option?
> > 
> > config PATENT_1234567890
> >         bool "Patent 1234567890"
> >         default n
> >         help
> >           Say Y here if you have the right to use
> >           patent 1234567890 (the foo patent). Some
> >           countries do not recognise this patent, an
> >           educational or research exemption may apply,
> >           you may be the patent holder, the patent
> >           may have expired, or you may have aquired
> >           rights via licensing. Seek legal help if you
> >           need advice concerning your rights. If unsure,
> >           say N.
> 
> I expect this was said in jest, but it would be delightful to see this
> done for real.  To the best of my knowlege it's uncharted territory,
> so perhaps what you suggest _would_ be upheld in a court of law as
> permissible?
> 

This approach would turn Linux into proprietary software.


- James
-- 
James Morris
<jmorris@redhat.com>


