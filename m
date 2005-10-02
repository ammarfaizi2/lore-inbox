Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVJBHHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVJBHHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 03:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVJBHHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 03:07:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63431 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750983AbVJBHHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 03:07:22 -0400
Date: Sun, 2 Oct 2005 00:07:12 -0700
From: Paul Jackson <pj@sgi.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: [PATCH] Document from line in patch format
Message-Id: <20051002000712.4689bbb2.pj@sgi.com>
In-Reply-To: <433F860C.7050807@gmail.com>
References: <20051002062135.32334.32895.sendpatchset@jackhammer.engr.sgi.com>
	<433F860C.7050807@gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony wrote:
> > +    listed in the last "Signed-off-by:" line in the message when Linus
>                      ^^^^ 
> Shouldn't this be the first?

When I sent a patch with no "from" line, and two "Signed-off-by"
lines (the patch that prompted this excursion into documentation
excellence) Linus stated that the patch author ended up coming from
the second "Signed-off-by" line.

Perhaps it "should" be the first (actually - I tend to agree),
but it seems that it "is" the last.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
