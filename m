Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281782AbRKQRVo>; Sat, 17 Nov 2001 12:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281783AbRKQRVd>; Sat, 17 Nov 2001 12:21:33 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:64784 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S281782AbRKQRVR>; Sat, 17 Nov 2001 12:21:17 -0500
Date: Sat, 17 Nov 2001 12:21:08 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Partha Narayanan <partha@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] scheduler cache affinity improvement in 2.4 kernels by
 Ingo Molnar
In-Reply-To: <OF130223C2.EFFE9842-ON85256B07.0052CC33@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.10.10111171219060.13938-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      The UniProcessor throughput  was reduced by 40%.
>      The 4-way throughput showed a very slight degradation of 1%.
>      The 8-way throughput showed an improvemnet of 10%.

what a waste of time: volanomark loopback is deliberately unlike
any real-world workload, so noone can sanely use these numbers.
why not compare to something vaguely intelligible?  even lmbench
would be more interesting...

