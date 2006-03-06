Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWCFSdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWCFSdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752390AbWCFSdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:33:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9148 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750703AbWCFSdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:33:50 -0500
Date: Mon, 6 Mar 2006 19:33:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ben Chelf <ben@coverity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coverity Open Source Defect Scan of Linux
Message-ID: <20060306183318.GA3825@elf.ucw.cz>
References: <440BCA0F.50501@coverity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440BCA0F.50501@coverity.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 05-03-06 21:35:11, Ben Chelf wrote:
> Hello Linux Developers,
> 
>   I'm the CTO of Coverity, Inc., a company that does static source code 
> analysis to look for defects in code. You may have heard of us or of our 
> technology from its days at Stanford (the "Stanford Checker"). The 
> reason I'm writing is because we have set up a framework internally to 
> continually scan open source projects and provide the results of our 
> analysis back to the developers of those projects. Linux is one of the 
> 32 projects currently scanned at:
> 
> http://scan.coverity.com
> 
>   My belief is that we (Coverity) must reach out to the developers of 
> these packages (you) in order to make progress in actually fixing the 
> defects that we happen to find, so this is my first step in that 
> mission. Of course, I think Coverity technology is great, but I want

Could you just open the (kernel) results to the public? Going after
warnings from compiler (afaics that's roughly what coverity is) is
ideal janitorial job, and job where many people -- not only core
developers -- can help.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
