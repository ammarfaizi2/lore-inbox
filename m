Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbSLDBZt>; Tue, 3 Dec 2002 20:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266793AbSLDBZt>; Tue, 3 Dec 2002 20:25:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:500 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266792AbSLDBZs>;
	Tue, 3 Dec 2002 20:25:48 -0500
Importance: Normal
Sensitivity: 
Subject: Re: IBM/MontaVista Dynamic Power Management Project
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk, linux-pm-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFB289F47E.E2B77FA5-ON86256C85.0006E2D1@pok.ibm.com>
From: "Bishop Brock" <bcbrock@us.ibm.com>
Date: Tue, 3 Dec 2002 19:32:52 -0600
X-MIMETrack: Serialize by Router on D01ML068/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 12/03/2002 08:33:02 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Alan Cox <alan@lxorguk.ukuu.org.uk> on 12/03/2002 12:39:56 PM
>> http://www.research.ibm.com/arl/projects/dpm.html
> Interesting. One small question however. The paper says "Others have
> also explored the possibilities of this type of fine grained control".
> More to the point however they have patents covering them. What does IBM
>intend to do about that ?

This is an important and complicated question.  Our code has passed an
internal IBM legal review,
however we are still discussing the implications of the patent with our
attorneys.
The best I can offer at this point is that we hope to have a definitive
answer next week.

The patent in question (US 6,298,448) deals with application-specific
dynamic scaling.
Although this is an important part of our proposal, it is not the central
idea, and I believe the
proposal has merit even if this portion were suppressed.


