Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVJBQ2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVJBQ2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 12:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVJBQ2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 12:28:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48842 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751120AbVJBQ2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 12:28:24 -0400
Date: Sun, 2 Oct 2005 09:28:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: adaplas@gmail.com, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: [PATCH] Document from line in patch format
Message-Id: <20051002092815.46ba1b69.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0510020831290.31407@g5.osdl.org>
References: <20051002062135.32334.32895.sendpatchset@jackhammer.engr.sgi.com>
	<433F860C.7050807@gmail.com>
	<20051002000712.4689bbb2.pj@sgi.com>
	<Pine.LNX.4.64.0510020831290.31407@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> No. If there is no "From:" at the top of the body, the authorship is taken 
> from the "From:" from the _email_.

So _that_ is the real reason it's called the "from" line,
not the "author" line.

Now it is making more sense.

New patch v2 coming soon.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
