Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269097AbUHXW5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269097AbUHXW5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269096AbUHXW5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:57:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:12714 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269097AbUHXWzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:55:43 -0400
Subject: Re: Linux 2.6.9-rc1
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <64420000.1093382553@[10.10.2.4]>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
	 <20040824184245.GE5414@waste.org>
	 <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
	 <64420000.1093382553@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1093388119.4030.116.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 15:55:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 14:22, Martin J. Bligh wrote:
> >From an automated tool point of view, it's easier to build a kernel
> with just tarball + 1 patch (I have much the same issues as Matt to deal
> with) ... also it works the same way as the current -rc releases, etc, 
> so it's consistent.

The post-releases have tarballs all by themselves, though.  So, you
shouldn't really have anything to worry about for any of the post
releases, unless you're using something like ketchup which skips the
tarballs in favor of patching.  

-- Dave

