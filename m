Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSHHPUE>; Thu, 8 Aug 2002 11:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSHHPUE>; Thu, 8 Aug 2002 11:20:04 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13527 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317591AbSHHPUE>; Thu, 8 Aug 2002 11:20:04 -0400
Subject: Re: bad: schedule() with irqs disabled! (+ ksymoops)
From: Paul Larson <plars@austin.ibm.com>
To: martin@dalecki.de
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D524A67.7030407@evision.ag>
References: <Pine.LNX.4.44.0208081218160.24255-100000@linux-box.realnet.co.sz> 
	<3D524A67.7030407@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Aug 2002 10:18:05 -0500
Message-Id: <1028819895.22405.313.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the same error yesterday with preempt turned on.  Turned it off
and it was no longer a problem but I hadn't had a chance to try
reproducing it on a clean kernel yet.

-Paul Larson

