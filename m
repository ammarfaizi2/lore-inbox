Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbULEClD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbULEClD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULEClD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:41:03 -0500
Received: from hera.kernel.org ([63.209.29.2]:1429 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261229AbULEClA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:41:00 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Proposal for a userspace "architecture portability" library
Date: Sun, 5 Dec 2004 02:40:49 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cotsfh$isn$1@terminus.zytor.com>
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1102214449 19352 127.0.0.1 (5 Dec 2004 02:40:49 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 5 Dec 2004 02:40:49 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
By author:    Paul Mackerras <paulus@samba.org>
In newsgroup: linux.dev.kernel
> 
> Now, clearly I can do this under the GPL.  However, I think it would
> be more useful to have the library under the LGPL, which requires
> either getting the permission of the authors of the kernel files, or
> rewriting them from scratch.
> 
> Linus (and other kernel copyright holders) - would you be willing to
> relicense such of the above files that have your copyright under the
> LGPL for this purpose?
> 
> I'm looking for volunteers to help with porting and testing on various
> architectures.  I can do x86, ppc and ppc64, and I know sparc{,64} and
> m68k assembler, but for the rest I'll need help.
> 

I can certainly pitch in.  I would personally prefer to see this under
the BSD license, (a) because it's not really that much code, and (b)
because it would let me add it to klibc.

	-hpa
