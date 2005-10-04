Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVJDSad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVJDSad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVJDSad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:30:33 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:24231 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964902AbVJDSac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:30:32 -0400
Subject: Re: [RFC][PATCH 2/2] Reduced NTP rework (part 2)
From: john stultz <johnstul@us.ibm.com>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>
In-Reply-To: <4342525D.31706.708950@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <1127419198.8195.10.camel@cog.beaverton.ibm.com>
	 <4342525D.31706.708950@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 11:30:29 -0700
Message-Id: <1128450629.8195.398.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 09:58 +0200, Ulrich Windl wrote:
> As playing with "tick" is considered obsolete by the NTP people, frequency errors 
> up to 500 PPM are corrected by the NTP kernel code. Thus, to provide continuous 
> time, you might be interested in adjusting tick interpolation (i.e. _use_ the 
> adjusted value whenever the clock is read).

Not sure if I followed that. Could you go into more detail please?

thanks
-john


