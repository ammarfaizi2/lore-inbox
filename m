Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbUDFAQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbUDFAQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:16:20 -0400
Received: from ibague.terra.com.br ([200.154.55.225]:31401 "EHLO
	ibague.terra.com.br") by vger.kernel.org with ESMTP id S263548AbUDFAQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:16:19 -0400
Subject: Re: 2.6.5 blank consoles (tty1-6)
From: Rafael Pereira <mosfet@phreaker.net>
To: Jason Harrison <jharrison@linuxbs.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200404042252.32393.jharrison@linuxbs.dyndns.org>
References: <200404042007.22998.jharrison@linuxbs.dyndns.org>
	 <1081128832.6937.21.camel@flipflop.mosfet.bit>
	 <200404042252.32393.jharrison@linuxbs.dyndns.org>
Content-Type: text/plain
Message-Id: <1081210580.11216.6.camel@flipflop.mosfet.bit>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 21:16:20 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Greetings,
> 
> I recompiled the 2.6.5 kernel with the options you specified below.  This 
> however made no change in regard to my situation.  I still have blank tty1-6 
> on my console.  I went back to using 2.6.4 which works fine.  
> 
> Please advise.
> 
> Regards,
> Jason Harrison
> 

Well....

I do not have the exact answer in mind now, but Try to make a Diff
between the 2.6.5 .config and the 2.6.4, i think you surely find the
cuase of this problem.


Rafael.

-- 
Rafael Pereira - GNU/Linux Registered User #286151
Sign petition against software patents http://petition.eurolinux.org
Say NO to mono project
Be free. Use free software.

