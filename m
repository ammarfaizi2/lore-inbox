Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVDEJyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVDEJyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVDEJwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:52:01 -0400
Received: from smtp-out.tiscali.no ([213.142.64.144]:30982 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261674AbVDEJrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:47:11 -0400
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jacek =?iso-8859-2?Q?=A3uczak?= <difrost@pin.if.uz.zgora.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1112289106.1829.10.camel@mindpipe>
References: <424AE48C.8000805@pin.if.uz.zgora.pl>
	 <1112263230.1165.15.camel@nc>  <1112289106.1829.10.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 11:47:09 +0200
Message-Id: <1112694429.32468.27.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 12:11 -0500, Lee Revell wrote:

> Didn't you ever look up what a ulimit is?

ofcourse i did. I just think that ulimit (or other userspace tools)
should be used to *raise* the limit if you need more. Not the reverse.

> If you consider your distro's default ulimits unreasonable, file a bug
> report with them.  But no one is going to make Linux "restrictive by
> default" to make life easier for people who don't bother to RTFM.

I already suggested ulimit solutions for my distro. They think that if
this is needed the kernel dev's would do something (ie its a kernel
problem) while the kernel dev's says this is a userspace prob.

I wouldn't bother if this was a problem for one or two distros only.
Now, almost all distros seems to be vulnerable by default.

I wouldn't bother if other *nixes would set this limit in userspace.
(the BSD's set the limit lower in kernel and let users who need more
raise with userland tools)

I wouldn't bother if this wouldn't give Linux a bad reputation.

I'm Sorry if I made some people upset.

--
Natanael Copa

