Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291214AbSCDDqQ>; Sun, 3 Mar 2002 22:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291248AbSCDDqG>; Sun, 3 Mar 2002 22:46:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:6411 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291214AbSCDDp5>;
	Sun, 3 Mar 2002 22:45:57 -0500
Subject: Re: latency & real-time-ness.
From: Robert Love <rml@tech9.net>
To: Ben Greear <greearb@candelatech.com>
Cc: J Sloan <joe@tmsusa.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C82EAD9.8010802@candelatech.com>
In-Reply-To: <E16hd1T-0005QW-00@the-village.bc.nu>
	<3C82A702.1030803@candelatech.com> <3C82CA19.9000702@tmsusa.com> 
	<3C82EAD9.8010802@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 03 Mar 2002 22:45:27 -0500
Message-Id: <1015213536.868.29.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-03 at 22:32, Ben Greear wrote:

> I found this patch:
> preempt-kernel-rml-2.4.19-pre2-ac2-1.patch
> 
> It applied cleanly...looks like maybe this isn't
> the low-latency patch though now that I look at
> it a little closer.

Right, it is not.  It is the preemptive kernel patch.  More information
can be found at http://tech9.net/rml/linux

	Robert Love

