Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWDGTRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWDGTRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDGTRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:17:36 -0400
Received: from mxsf03.cluster1.charter.net ([209.225.28.203]:17894 "EHLO
	mxsf03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932361AbWDGTRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:17:35 -0400
X-IronPort-AV: i="4.04,98,1144036800"; 
   d="scan'208"; a="178285809:sNHT599870838"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17462.47818.652096.604638@smtp.charter.net>
Date: Fri, 7 Apr 2006 15:17:30 -0400
From: "John Stoffel" <john@stoffel.org>
To: "Joshua Hudson" <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] Add a /proc/self/exedir link
In-Reply-To: <bda6d13a0604071201h64bfab2av21c8c3e0bbd8af0d@mail.gmail.com>
References: <5XGlt-GY-23@gated-at.bofh.it>
	<5XGOz-1eP-35@gated-at.bofh.it>
	<E1FRSqP-0000g3-9i@be1.lrz>
	<443515E1.1000600@plan99.net>
	<Pine.LNX.4.58.0604061841150.1941@be1.lrz>
	<44356DAA.90209@plan99.net>
	<m164llns9p.fsf@ebiederm.dsl.xmission.com>
	<bda6d13a0604071201o36496a55o2eae6a65153a06c3@mail.gmail.com>
	<bda6d13a0604071201h64bfab2av21c8c3e0bbd8af0d@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Joshua" == Joshua Hudson <joshudson@gmail.com> writes:

Joshua> Excellent point. This proposal needs to die, but there needs
Joshua> to be some way to solve this problem.

Why don't you try to explain the problem in more depth, but without
assuming a solution at all.  Just talk about what you're trying to
fix.  

As a SysAdmin by trade, if the program is written sanely, it's not
hard to make it relocateable and runable from anywhere.  It's when the
program *knows* or the libraries is uses *know* that stuff is in
certain locations that things break.  

I'm really writing from memory here, since I first saw your proposal
and looked it over and went "why bother?" but didn't have the time to
check it out in detail.  

John
