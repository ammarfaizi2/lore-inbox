Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWHaQZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWHaQZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWHaQZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:25:24 -0400
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:55463 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932364AbWHaQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:25:23 -0400
Date: Thu, 31 Aug 2006 12:17:14 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386: rwlock.h fix smp alternatives fix
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200608311221_MC3-1-C9EE-3548@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608311011.45844.ak@suse.de>

On Thu, 31 Aug 2006 10:11:45 +0200, Andi Kleen wrote:

> Here's the patch as intended for reference :/ Or Chris' incremental
> is fine.
> 
> i386: Remove alternative_smp
> 
> The .fill causes miscompilations with some binutils version.

Has the dust settled enough to prepare a patch for -stable now?

-- 
Chuck

