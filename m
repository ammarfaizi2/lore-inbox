Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVDHWXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVDHWXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDHWXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:23:37 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:31687 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261171AbVDHWTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:19:40 -0400
Subject: Re: Odd Timer behavior in 2.6 vs 2.4  (1 extra tick)
From: Steven Rostedt <rostedt@goodmis.org>
To: jdavis@accessline.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 08 Apr 2005 18:19:30 -0400
Message-Id: <1112998770.24574.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 10:39 -0700, jdavis@accessline.com wrote:
> 
> Hello, 
> 
> I've created a pretty straight forward timer using setitimer, and noticed
> some odd differences between 2.4 and 2.6, I wonder if I could get a
> clarification if this is the way it should work, or if I should continue to
> try to "fix" it.

Hi, could you send me a simple program that shows the latency, then I'll
be able to analysis exactly where the problem (if there is a problem)
is.

-- Steve


