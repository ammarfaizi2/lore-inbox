Return-Path: <linux-kernel-owner+w=401wt.eu-S932434AbXAGIkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbXAGIkY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 03:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbXAGIkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 03:40:24 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:52726 "EHLO
	liaag2ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932434AbXAGIkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 03:40:23 -0500
Date: Sun, 7 Jan 2007 03:35:21 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.16.37
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200701070337_MC3-1-D79B-2928@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20070104222517.GL20714@stusta.de>

On Thu, 4 Jan 2007 23:25:17 +0100, Adrian Bunk wrote:

> There's already a CVE number for
> "i386: save/restore eflags in context switch".
> 
> Are there also CVE numbers for the equivalent x86_64 patch and
> "x86_64: fix ia32 syscall count"?

Sorry, my Web access is broken for now so I can't check, but I believe
that CVE number is for a different, older problem.

So AFAIK there are no CVE numbers for anything I sent (but there
probably should be.)  Generic Linux kernel developers don't have
a CVE representative, so we depend on vendors to assign numbers
and sometimes they don't.

-- 
"That's the problem with non-representational art:
 you can't tell which part offends you."
     --Stephen Colbert
