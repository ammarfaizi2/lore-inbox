Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUHDQXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUHDQXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267331AbUHDQXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:23:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:47000 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266208AbUHDQXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:23:23 -0400
Date: Wed, 4 Aug 2004 09:23:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: James Morris <jmorris@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc3
In-Reply-To: <4110FB0E.230CE613@users.sourceforge.net>
Message-ID: <Pine.LNX.4.58.0408040909580.24588@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
 <4110FB0E.230CE613@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Aug 2004, Jari Ruusu wrote:
>
> Linus Torvalds wrote:
> > Summary of changes from v2.6.8-rc2 to v2.6.8-rc3
> [snip]
> > James Morris:
> >   o [CRYPTO]: Add i586 optimized AES
> 
> My work on aes-i586.S is only licensed under original three clause BSD
> license. You do not have my permission to change the license.
> 
> Either use original license or drop this code.

We'll drop it immediately. It should be easy enough to get somebody saner 
than you to re-convert from the original AES code which is dual-GPL'd.

		Linus
