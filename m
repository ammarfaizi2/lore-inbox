Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWIAMed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWIAMed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 08:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIAMed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 08:34:33 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:52637 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751133AbWIAMec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 08:34:32 -0400
Date: Fri, 1 Sep 2006 14:30:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 01/16] GFS2: Core header files
In-Reply-To: <1157109170.3384.831.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609011425280.15283@yvahk01.tjqt.qr>
References: <1157030918.3384.785.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0608311607441.5900@yvahk01.tjqt.qr> 
 <1157036840.3384.827.camel@quoit.chygwyn.com>  <Pine.LNX.4.61.0608311929100.19403@yvahk01.tjqt.qr>
 <1157109170.3384.831.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=e9fc2aa091ab8fa46e60d4c9d06a89305c441652
>
>addresses the issues you raised in your first email. I'm working on a
>patch to deal with the second set of issues you raised at the moment,

Yes that looks good. The 'uint32_t __pad' -> 'u32 __pad' change I will 
address in the next mail I am currently composing.

(And if I may add: I would have split that commit into three commits - one 
for each paragraph you wrote in the changelog :-)

Hm copy and paste from Firefox to xterm removes all the indenting.
opening the url with w3m already has all indent removed too. What's wrong with
the gitweb today? :-(



Jan Engelhardt
-- 
