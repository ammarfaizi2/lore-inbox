Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWGNSQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWGNSQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWGNSQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:16:34 -0400
Received: from canuck.infradead.org ([205.233.218.70]:41388 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1422652AbWGNSQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:16:33 -0400
Subject: Re: Kernel headers git tree
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
In-Reply-To: <200607142005.36998.ioe-lkml@rameria.de>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <200607142005.36998.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 19:16:11 +0100
Message-Id: <1152900971.3191.76.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 20:05 +0200, Ingo Oeser wrote:
> Hi David,
> 
> On Friday, 14. July 2006 01:59, David Woodhouse wrote:
> > Only commits in Linus' tree which actually affect the exported result
> > should have an equivalent commit in the above tree, which means that any
> > changes which affect userspace should be clearly visible for review.
> 
> Where can I subscribe for commit messages there?

Well, they're all derived from commits in Linus' tree. I could set up
another mailing list feed script which tracks it, but I'd like to give
it a while (until I'm happy with the export scripts) first.

-- 
dwmw2

