Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264185AbUDGT6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUDGT6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:58:51 -0400
Received: from main.gmane.org ([80.91.224.249]:5334 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264185AbUDGT6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:58:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Rewrite Kernel
Date: Wed, 07 Apr 2004 21:58:46 +0200
Message-ID: <yw1xzn9n5zm1.fsf@kth.se>
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com> <1081348038.5049.6.camel@redeeman.linux.dk>
 <200404071455.i37EtOn8000182@81-2-122-30.bradfords.org.uk>
 <20040407150516.GC23517@marowsky-bree.de> <40744481.7050002@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-13635.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:aJZ0ZACeynzSNO2Fb9IGxhI+dn0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Smith <aws4y@virginia.edu> writes:

> Lars Marowsky-Bree wrote:
>
>>Guys, gals,
>>
>>you are all missing the point.
>>
>>It is obvious that what we really need is a hand-optimized in-kernel
>>core LISP machine written in >i386 assembly, then we need to port the
>>rest of the kernel to run as LISP bytecode on top of that in ring1 (in
>>particular the security policies).
>>
>>Of course, important privileged user-space such as glibc should be
>>ported to this highly efficient non-recursive LISP machine too for
>>efficiency and run on ring 2 for speed and security.
>>
>>
> What you are talking about is a LISP machine micro-kernel in Ring0
> which sort of defeats the whole point of Linux being monolithic
> kernel. Also couldn't we just run HURD, or for that matter EMACS ;-),

Yes, I use Emacs as my operating system.  It uses Linux as a device
driver.

-- 
Måns Rullgård
mru@kth.se

