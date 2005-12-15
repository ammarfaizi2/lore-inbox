Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVLOTEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVLOTEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVLOTEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:04:13 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41133 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750918AbVLOTEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:04:11 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Lee Revell <rlrevell@joe-job.com>
To: Al Boldi <a1426z@gawab.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512152129.01861.a1426z@gawab.com>
References: <200512150013.29549.a1426z@gawab.com>
	 <200512151131.39216.a1426z@gawab.com> <43A1501F.5070803@aitel.hist.no>
	 <200512152129.01861.a1426z@gawab.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 14:06:52 -0500
Message-Id: <1134673613.12086.150.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 21:29 +0300, Al Boldi wrote:
> > how is non-OpenSource different? What can we do better? How can we
> > learn from them?
> 
> Pretty much nothing, except for taking advantage of their precooked 
> interconnectivity api's, in which they excel in abstracting them
> pretty 
> well.
> 

Sorry you are just WRONG here.  If you wanted to do low latency audio on
Windows 4 years ago you were fucked because the kernel mixer adds 30ms
of latency and there's no API to bypass it!  Haha, you lose.

Eventually Cakewalk figured out an undocumented unsupported method
called "Kernel Streaming" to bypass the kernel mixer.  God knows how
many man hours were wasted on this problem.

Please drop your ridiculous assertion that stable APIs don't impede
progress.  To create an stable API that would support new and innovative
future applications would require a LOT of foresight.  It's MUCH easier
to just change the API when someone comes up with an application the old
one can't support.

Lee

