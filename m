Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVETSbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVETSbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVETSbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:31:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37851 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261539AbVETSas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:30:48 -0400
Subject: Re: [RFC] how do we move the VM forward? (was Re: [RFC] cleanup
	ofuse-once)
From: Lee Revell <rlrevell@joe-job.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: David Lang <david.lang@digitalinsight.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Rik van Riel <riel@redhat.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050520181606.GB6002@MAIL.13thfloor.at>
References: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com>
	 <42771904.7020404@yahoo.com.au>
	 <Pine.LNX.4.61.0505030913480.27756@chimarrao.boston.redhat.com>
	 <42781AC5.1000201@yahoo.com.au>
	 <Pine.LNX.4.62.0505031749010.12818@qynat.qvtvafvgr.pbz>
	 <20050520181606.GB6002@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Fri, 20 May 2005 14:30:43 -0400
Message-Id: <1116613844.29740.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 20:16 +0200, Herbert Poetzl wrote:
> cool, looks like they are taking the MS compatibility
> really serious nowadays ...
> 

Um... I don't know when you last used Windows, but most Linux desktop
GUI apps are way more bloated than the Windows counterparts.  Take a
look at some of the Gnome bounties for reducing bloat - some of them are
just embarassing.

Quick demo: with a recent Gnome, open the file selector dialog, and
browse to /usr/bin.  The disk goes nuts for 20 seconds before the file
list is even displayed.  Now hit cancel and try it again.  No disk
activity this time, but the CPU pegs for 7-8 seconds before the files
are displayed.

Now try the same on Windows.  It's instantaneous.

Lee

