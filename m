Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbUDGPOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 11:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUDGPOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 11:14:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:29056 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263706AbUDGPOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 11:14:03 -0400
Date: Wed, 7 Apr 2004 16:17:38 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200404071517.i37FHcl9000322@81-2-122-30.bradfords.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040407150516.GC23517@marowsky-bree.de>
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
 <1081348038.5049.6.camel@redeeman.linux.dk>
 <200404071455.i37EtOn8000182@81-2-122-30.bradfords.org.uk>
 <20040407150516.GC23517@marowsky-bree.de>
Subject: Re: Rewrite Kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is obvious that what we really need is a hand-optimized in-kernel
> core LISP machine written in >i386 assembly, then we need to port the
> rest of the kernel to run as LISP bytecode on top of that in ring1 (in
> particular the security policies).
> 
> Of course, important privileged user-space such as glibc should be
> ported to this highly efficient non-recursive LISP machine too for
> efficiency and run on ring 2 for speed and security.

Errr, no, I don't think so :-).

John.
