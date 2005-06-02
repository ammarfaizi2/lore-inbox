Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFBScd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFBScd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 14:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFBScd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 14:32:33 -0400
Received: from mout.perfora.net ([217.160.230.41]:37347 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S261222AbVFBSca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 14:32:30 -0400
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
From: Christopher Warner <chris@servertogo.com>
To: "Peter J. Stieber" <developer@toyon.com>
Cc: ak@suse.de, cwarner@kernelcode.com, Dave Jones <davej@redhat.com>,
       Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       linux-kernel@vger.kernel.org, Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <028601c5678f$ee26c670$1600a8c0@toyon.corp>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB>
	 <037801c5616a$b1be6600$1600a8c0@toyon.corp> <4295E9F1.6080304@tmr.com>
	 <022e01c56233$241e5930$1600a8c0@toyon.corp>
	 <1117156446.8874.41.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0505262112540.32548@twin.uoregon.edu>
	 <1117190965.13932.36.camel@sabrina>
	 <02b301c562e1$41351a50$1600a8c0@toyon.corp>
	 <20050527190918.GB7923@redhat.com>
	 <037601c562f5$a66343c0$1600a8c0@toyon.corp>
	 <028601c5678f$ee26c670$1600a8c0@toyon.corp>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 09:50:01 -0400
Message-Id: <1117720201.22578.92.camel@sabrina>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 09:27 -0700, Peter J. Stieber wrote:
> CW = Christopher Warner
> CW>>>> The tyan boards I have in here right now appear to
> CW>>>> work properly except for the pmd issue, i've noticed
> CW>>>> nothing wrong with them besides that.
> 
> PS = Peter J. Stieber
> PS>>> Same here.
> 
> CW>>>> What we need is to try and single out the variables that
> CW>>>> are causing the badpmd's. Also the more people who
> CW>>>> report badpmd's with Andi Kleen's intial patch the better.
> CW>>>> Especially on different archs; would also be good. So
> CW>>>> far from lkml i'm only seeing Tyan S28* boards as of
> CW>>>> recent.
> 
> PS>>> Does the Dave Jones provided Fedora Core 3 kernel I'm running
> PS>>> (2.6.11-1.29_FC3smp) have Andi's patch?
> PS>>>
> PS>>> I guess that question was fo Dave ;-)
> 
> DJ = Dave Jones
> DJ>> not the latest iteration no.
> 
> PS> I'd be willing to try it if you could provide it Dave.
> 
> I (and others) have been running a new FC3 kernel provided by Dave 
> (2.6.11-1.31_FC3smp) for a while know and it seems to have fixed this 
> problem.
> 
> https://www.redhat.com/archives/fedora-list/2005-June/msg00243.html
> https://www.redhat.com/archives/fedora-list/2005-June/msg00246.html
> 
> Dave will have to comment with respect to what changes were made to this 
> version.
> Pete 

If it's just the 2.6.11.11 inclusion as Dave said then i'll upgrade and
see what happens if anything. Hopefully, it's beating a dead horse;
dead.

Thanks everyone for the help and thanks to Andi and whoever else
actually fixed it :-)

Christopher Warner


