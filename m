Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbSKORpZ>; Fri, 15 Nov 2002 12:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbSKORpZ>; Fri, 15 Nov 2002 12:45:25 -0500
Received: from main.gmane.org ([80.91.224.249]:7609 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S266675AbSKORpY>;
	Fri, 15 Nov 2002 12:45:24 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Jason Lunz <lunz@falooley.org>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Date: Fri, 15 Nov 2002 16:43:29 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnata94s.4ct.lunz@stoli.localnet>
References: <1037325839.13735.4.camel@rth.ninka.net> <396026666.1037298946@[10.10.2.3]> <200211142153.56373.lkml@digitaleric.net>
NNTP-Posting-Host: dsl-65-188-226-101.telocity.com
X-Trace: main.gmane.org 1037378609 9718 65.188.226.101 (15 Nov 2002 16:43:29 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Fri, 15 Nov 2002 16:43:29 +0000 (UTC)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml@digitaleric.net said:
> Would this be an appropriate use of the "version" tag in Bugzilla?
> Currently the only choice is "2.5", but if that were renamed to
> "2.5-linus", then the other heavily used patchsets could be monitored
> while making it easy for people who only want to see bugs in Linus'
> tree.

Definitely. Properly used, bugzilla can track any number of kernel
trees. You can craft bugzilla queries to only show you bugs against the
versions you're interested in.

Jason


