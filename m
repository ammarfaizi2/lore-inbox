Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTKTKIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTKTKIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:08:37 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:25814 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261595AbTKTKIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:08:36 -0500
Date: Thu, 20 Nov 2003 11:08:29 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sumit Pandya <sumit@elitecore.com>
Cc: linux-kernel@vger.kernel.org, joern@wohnheim.fh-wedel.de
Subject: Re: Infinite do_IRQ
Message-ID: <20031120100829.GB2843@wohnheim.fh-wedel.de>
References: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 November 2003 12:58:48 +0530, Sumit Pandya wrote:
> 
>     I'd also like to draw your attention on one more patch by Joern Engel
> (He is in CC list)
> http://wh.fh-wedel.de/~joern/software/kernel/je/24/.patches/stack_overflow.p
> atch
>     Are these patches safe to apply? What could be pros and cons if these
> patches are applied into 2.4.22 kernel.

That patch intends to make things worse, not better.  Just a test tool
to find problems early.  Should be pointless for you.

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
