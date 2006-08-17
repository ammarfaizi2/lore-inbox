Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWHQUHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWHQUHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWHQUHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:07:10 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:25510 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030234AbWHQUHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:07:09 -0400
Date: Thu, 17 Aug 2006 16:03:23 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
  /usr/src/linux-git/kernel/cpu.c:51
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>
Message-ID: <200608171605_MC3-1-C870-818F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44E1D8CD.76E4.0078.0@novell.com>

On Tue, 15 Aug 2006 14:23:09 +0200, Jan Beulich wrote:

> Again, if "unwinder stuck" messages appear, I'll need a raw
> stack dump to accompany the stack trace.

So people who want to help debug the stuck unwinder should be
booting with "kstack=2048" on i386 in order to get the full stack
dump.

-- 
Chuck

