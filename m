Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVFHCj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVFHCj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVFHCj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:39:56 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:6022 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262056AbVFHCjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:39:54 -0400
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christian Schmid <webmaster@rapidforum.com>
Cc: Ben Greear <greearb@candelatech.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42A65759.8050507@rapidforum.com>
References: <4229E805.3050105@rapidforum.com>
	 <422BAAC6.6040705@candelatech.com>	<422BB548.1020906@rapidforum.com>
	 <422BC303.9060907@candelatech.com>	<422BE33D.5080904@yahoo.com.au>
	 <422C1D57.9040708@candelatech.com>	<422C1EC0.8050106@yahoo.com.au>
	 <422D468C.7060900@candelatech.com>	<422DD5A3.7060202@rapidforum.com>
	 <422F8A8A.8010606@candelatech.com>	<422F8C58.4000809@rapidforum.com>
	 <422F9259.2010003@candelatech.com>	<422F93CE.3060403@rapidforum.com>
	 <20050309211730.24b4fc93.akpm@osdl.org> <4231B95B.6020209@rapidforum.com>
	 <4231ED18.2050804@candelatech.com>  <4231F112.60403@rapidforum.com>
	 <1110775215.5131.17.camel@npiggin-nld.site> <423518C7.10207@rapidforum.com>
	 <1110776689.5131.37.camel@npiggin-nld.site>
	 <42A65759.8050507@rapidforum.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 12:39:46 +1000
Message-Id: <1118198386.5104.60.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 04:26 +0200, Christian Schmid wrote:
> This makes me seriously to despair.... the bug/lock/freeze is still there in 2.6.12rc6 ...
> 

Unfortunately yes, because we weren't able to track it down, and
nobody else has hit the problem.

I'm fairly busy for the next week, but I'll get back to you and
try to help after that.

You know, it would be *really* useful if you could provide some
code or point to some packages that can be used to reproduce the
problem. IIRC you hadn't been able to do that?


Nick

-- 
SUSE Labs, Novell Inc.




Send instant messages to your online friends http://au.messenger.yahoo.com 
