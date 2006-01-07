Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWAGFlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWAGFlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWAGFlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:41:15 -0500
Received: from hulk.jobsahead.com ([202.138.125.174]:19180 "EHLO
	hulk.jobsahead.com") by vger.kernel.org with ESMTP id S932666AbWAGFlO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:41:14 -0500
Subject: Re: High load
From: Aniruddh Singh <aps@jobsahead.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <1136569073.2940.54.camel@laptopd505.fenrus.org>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
	 <200601052100.45107.kernel@kolivas.org>
	 <1136550971.5557.2.camel@aps.monsterindia.noida>
	 <1136552226.2940.35.camel@laptopd505.fenrus.org>
	 <1136562410.5557.4.camel@aps.monsterindia.noida>
	 <1136569073.2940.54.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 11:17:09 +0530
Message-Id: <1136612829.5557.6.camel@aps.monsterindia.noida>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4.asl) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > > for measuring IO performance, I'd recommend tiobench over hdparm any day
> > > ( http://tiobench.sf.net )
> > 
> > i will do it, can you please tell me why load goes high when i compile
> > kernel (10 and above)
> 
> thats really odd, unless you do a "make -j", in which case of course
> it's expected ;)
yes i always use make -j option ??
-- 
Regards
Aniruddh Singh
System Administrator
Monster.com India Pvt. Ltd.
FC 23, Block B, 1st Floor, Sector 16A
Film City Noida 201301 U.P.


