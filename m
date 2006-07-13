Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWGMQaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWGMQaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWGMQaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:30:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56465 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932486AbWGMQaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:30:08 -0400
Subject: Re: 2.6.18-rc1-mm1 oom with nvidia driver + ut2004?
From: Lee Revell <rlrevell@joe-job.com>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060713181019.2055a9f0@phoebee>
References: <20060713181019.2055a9f0@phoebee>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 12:30:17 -0400
Message-Id: <1152808218.8237.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 18:10 +0200, Martin Zwickel wrote:
> Hi there!
> 
> I don't know if it's a kernel or nvidia driver issue, but maybe someone
> has some clue:
> 
> I tried 2.6.18-rc1-mm1 today with the nvidia driver 1.0.8762.
> I enabled CONFIG_SWAP_PREFETCH and CONFIG_ADAPTIVE_READAHEAD in kernel
> config (attached).
> 
> 
> Then I wanted to start ut2004 and got this OOM:
> 

Nvidia driver issue.

Even if it were a kernel issue, we can't support proprietary drivers on
this list - you'd have to reproduce it without nvidia loaded.

Lee

