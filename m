Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUGVDMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUGVDMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 23:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUGVDMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 23:12:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:50069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266683AbUGVDMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 23:12:34 -0400
Date: Wed, 21 Jul 2004 23:11:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
Message-Id: <20040721231128.6b495d94.akpm@osdl.org>
In-Reply-To: <200407220216.i6M2GqEv007394@magilla.sf.frob.com>
References: <m3eknaj39p.fsf@averell.firstfloor.org>
	<200407220216.i6M2GqEv007394@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> > Hmm, but now the behaviour for 32bit processes is different from the
> > native 32bit kernel, since 32bit didn't apply any patch so far AFAIK.
> 
> Well, I was (and am) advocating that Davide's patch for native 32-bit be
> applied as well.  If it is, then my last x86-64 patch covers both 32-bit
> and 64-bit cases with minimal cruft.  In particular, 2.6.8-rc1-mm1 contains
> Davide's patch and both of my earlier x86-64 patches.  I hope Andrew will
> replace those two patches with the later cleaner single x86-64 patch.  If
> Linus merges that patch of mine and Davide's i386 patch, I will be a happy
> camper.

Am now all confused.  Please tell me which patches to drop, and ensure that
I have the replacement patches, if any.  Thanks.

