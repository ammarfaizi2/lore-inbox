Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbUCTHMy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 02:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbUCTHMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 02:12:54 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:35289 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263242AbUCTHMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 02:12:53 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kgdb-bugreport] Move eth into 'lite' series?
Date: Sat, 20 Mar 2004 12:42:21 +0530
User-Agent: KMail/1.5
References: <20040319210322.GA13141@smtp.west.cox.net>
In-Reply-To: <20040319210322.GA13141@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403201242.21578.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 Mar 2004 2:33 am, Tom Rini wrote:
> I was thinking, now that netpoll is in 2.6.5-rc1, should we move the
> kgdboe driver into the -lite series?  I'd like to say Yes, with a quick
> check over the include list.

Let's wait till current session to push kgdb into mainline kernel is over. We 
need not push kgdboe into lite series, we can push it into mainline kernel 
itself :-)

I was supposed to submit second version of lite patches monday this week, but 
was preempted by some other work. I'll post them on coming monday now


-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

