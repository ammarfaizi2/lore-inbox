Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVCHVyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVCHVyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 16:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVCHVyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 16:54:35 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58348 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261573AbVCHVyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 16:54:14 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       paul@linuxaudiosystems.com, mpm@selenic.com, joq@io.com,
       cfriesen@nortelnetworks.com, Chris Wright <chrisw@osdl.org>,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050308212027.GA17664@infradead.org>
References: <20050112185258.GG2940@waste.org>
	 <200501122116.j0CLGK3K022477@localhost.localdomain>
	 <20050307195020.510a1ceb.akpm@osdl.org>
	 <20050308035503.GA31704@infradead.org>
	 <20050307201646.512a2471.akpm@osdl.org> <20050308042242.GA15356@elte.hu>
	 <20050307202821.150bd023.akpm@osdl.org>
	 <20050308043250.GA32746@infradead.org> <1110308156.4401.4.camel@mindpipe>
	 <20050308212027.GA17664@infradead.org>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 16:34:33 -0500
Message-Id: <1110317673.5982.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 21:20 +0000, Christoph Hellwig wrote:
> On Tue, Mar 08, 2005 at 01:55:55PM -0500, Lee Revell wrote:
> > And as I mentioned a few times, the authors have neither the inclination
> > nor the ability to do that, because they are not kernel hackers.  The
> > realtime LSM was written by users (not developers) of the kernel, to
> > solve a specific real world problem.  No one ever claimed it was the
> > correct solution from the kernel POV.
> 
> And I told you that doesn't matter.  If someone wants a feature in they
> should find a way to make it palable.  We're not accepting such excuses
> to put in crap.
> 

Fine.  Consider it a proof of concept.  I'm satisfied if any solution
gets merged, it doesn't have to be this one.

I am still confused about why the LSM framework was merged in the first
place.

Lee

