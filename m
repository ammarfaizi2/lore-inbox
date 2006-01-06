Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752259AbWAFRPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbWAFRPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWAFRPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:15:42 -0500
Received: from hulk.jobsahead.com ([202.138.125.174]:47812 "EHLO
	hulk.jobsahead.com") by vger.kernel.org with ESMTP id S1752259AbWAFRPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:15:42 -0500
Subject: Re: High load
From: Aniruddh Singh <aps@jobsahead.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <1136552226.2940.35.camel@laptopd505.fenrus.org>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
	 <200601052100.45107.kernel@kolivas.org>
	 <1136550971.5557.2.camel@aps.monsterindia.noida>
	 <1136552226.2940.35.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 21:16:50 +0530
Message-Id: <1136562410.5557.4.camel@aps.monsterindia.noida>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4.asl) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 13:57 +0100, Arjan van de Ven wrote:
> On Fri, 2006-01-06 at 18:06 +0530, Aniruddh Singh wrote:
> > Hi,
> > 
> > there is a raid 0 and raid controller is Smart Array 64xx (rev 01)
> > 
> > hdparm -tT /dev/cciss/c0d0p2 returns the following
> 
> for measuring IO performance, I'd recommend tiobench over hdparm any day
> ( http://tiobench.sf.net )

i will do it, can you please tell me why load goes high when i compile
kernel (10 and above)
> 
> 
-- 
Regards
Aniruddh Singh
System Administrator
Monster.com India Pvt. Ltd.
FC 23, Block B, 1st Floor, Sector 16A
Film City Noida 201301 U.P.


