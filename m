Return-Path: <linux-kernel-owner+w=401wt.eu-S965076AbWL2SH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWL2SH0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 13:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWL2SH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 13:07:26 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:43816 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965076AbWL2SH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 13:07:26 -0500
Subject: Re: 2.6.20-rc2: known unfixed regressions
From: Ben Collins <ben.collins@ubuntu.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Holbach <daniel.holbach@ubuntu.com>
In-Reply-To: <20061228223909.GK20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
	 <20061228223909.GK20714@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Dec 2006 13:07:10 -0500
Message-Id: <1167415630.5348.599.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 23:39 +0100, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.

> Subject    : i386: Oops in __find_get_block()
> References : http://lkml.org/lkml/2006/12/16/138
> Submitter  : Ben Collins <ben.collins@ubuntu.com>
>              Daniel Holbach <daniel.holbach@ubuntu.com>
> Status     : unknown

I believe this is the same bug as I've seen reported about gdb. I'd have
to find the thread/information regarding it. Not sure if it was fixed
already.
