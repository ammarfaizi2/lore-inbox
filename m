Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUHZJ6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUHZJ6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUHZJxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:53:53 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:38589 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S268030AbUHZIrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:47:20 -0400
Subject: Re: [PATCH] - trivial comment fixups in init/main.c
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tim Bird <tim.bird@am.sony.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       Adam Kropelin <akropel1@rochester.rr.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040817184210.A24533@infradead.org>
References: <20040817095601.4E7F22BEC3@ozlabs.org>
	 <41224105.5050706@am.sony.com>  <20040817184210.A24533@infradead.org>
Content-Type: text/plain
Message-Id: <1093509764.13514.2522.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 18:42:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-18 at 03:42, Christoph Hellwig wrote:
> > Fine with me.  These comments were modified at the request of
> > Andrew Morton, who wanted the comment style to be consistent.
> > I actually agree with your position, but I wanted to follow
> > what Andrew wanted here.
> 
> Please fix the comments anyway.  Rusty's preffered style is by far the
> minority in core kernel code.

I went back and looked; you're right.  Generally, I hate to waste
vertical whitespace inside a function.

As I said, the balance with a color-coded editor is different than when
reading code on paper.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

