Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282095AbRKWJwh>; Fri, 23 Nov 2001 04:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282106AbRKWJwa>; Fri, 23 Nov 2001 04:52:30 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20682 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282095AbRKWJvo>;
	Fri, 23 Nov 2001 04:51:44 -0500
Date: Fri, 23 Nov 2001 12:48:42 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Partha Narayanan <partha@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler cache affinity improvement in 2.4 kernels by
 Ingo Molnar
In-Reply-To: <OF130223C2.EFFE9842-ON85256B07.0052CC33@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.33.0111231247210.3988-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Nov 2001, Partha Narayanan wrote:

>      The UniProcessor throughput  was reduced by 40%.
>      The 4-way throughput showed a very slight degradation of 1%.
>      The 8-way throughput showed an improvemnet of 10%.

thanks Partha for the measurements. I'll soon post an updated patch that
also includes some of the suggestions from this list.

	Ingo

