Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWIALIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWIALIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWIALIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:08:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56522 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751457AbWIALIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:08:50 -0400
Subject: Re: [PATCH 01/16] GFS2: Core header files
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0608311929100.19403@yvahk01.tjqt.qr>
References: <1157030918.3384.785.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0608311607441.5900@yvahk01.tjqt.qr>
	 <1157036840.3384.827.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0608311929100.19403@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 01 Sep 2006 12:12:50 +0100
Message-Id: <1157109170.3384.831.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-08-31 at 19:30 +0200, Jan Engelhardt wrote:
> >> 
> >or you could argue that the addition of a space (i.e. v. 2) would be
> >correct since its an abbreviation, but point taken and I'll clean it up
> >shortly.
> 
> Or spell it out, as in many GPL headers.
> 
Yes, thats my chosen solution for now.
I hope this:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=e9fc2aa091ab8fa46e60d4c9d06a89305c441652

addresses the issues you raised in your first email. I'm working on a
patch to deal with the second set of issues you raised at the moment,

Steve.


