Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVE0TxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVE0TxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVE0TxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:53:05 -0400
Received: from mail.toyon.com ([65.160.147.241]:42690 "EHLO mail.toyon.com")
	by vger.kernel.org with ESMTP id S262559AbVE0TxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:53:01 -0400
Message-ID: <037601c562f5$a66343c0$1600a8c0@toyon.corp>
From: "Peter J. Stieber" <developer@toyon.com>
To: "Dave Jones" <davej@redhat.com>
Cc: "Christopher Warner" <chris@servertogo.com>,
       "Joel Jaeggli" <joelja@darkwing.uoregon.edu>,
       <linux-kernel@vger.kernel.org>, "Bill Davidsen" <davidsen@tmr.com>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB> <037801c5616a$b1be6600$1600a8c0@toyon.corp> <4295E9F1.6080304@tmr.com> <022e01c56233$241e5930$1600a8c0@toyon.corp> <1117156446.8874.41.camel@localhost.localdomain> <Pine.LNX.4.62.0505262112540.32548@twin.uoregon.edu> <1117190965.13932.36.camel@sabrina> <02b301c562e1$41351a50$1600a8c0@toyon.corp> <20050527190918.GB7923@redhat.com>
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
Date: Fri, 27 May 2005 12:52:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CW = Christopher Warner
CW>>> The tyan boards I have in here right now appear to
CW>>> work properly except for the pmd issue, i've noticed
CW>>> nothing wrong with them besides that.

PS = Peter J. Stieber
PS>> Same here.

CW>>> What we need is to try and single out the variables that
CW>>> are causing the badpmd's. Also the more people who
CW>>> report badpmd's with Andi Kleen's intial patch the better.
CW>>> Especially on different archs; would also be good. So
CW>>> far from lkml i'm only seeing Tyan S28* boards as of
CW>>> recent.

PS>> Does the Dave Jones provided Fedora Core 3 kernel I'm running 
PS>> (2.6.11-1.29_FC3smp) have Andi's patch?
PS>> 
PS>> I guess that question was fo Dave ;-)

DJ = Dave Jones 
DJ> not the latest iteration no.

I'd be willing to try it if you could provide it Dave.
Pete

