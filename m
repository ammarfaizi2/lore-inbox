Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319560AbSH3Mvh>; Fri, 30 Aug 2002 08:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319561AbSH3Mvh>; Fri, 30 Aug 2002 08:51:37 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:35218 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S319560AbSH3Mvh>;
	Fri, 30 Aug 2002 08:51:37 -0400
Message-ID: <1030712158.3d6f6b5ea7afa@kolivas.net>
Date: Fri, 30 Aug 2002 22:55:58 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: Performance patches (ck) update for stable kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



After the positive feedback I got from my merged patches for 2.4.19 I have
updated them.

-ck5 includes:

Scheduler O(1)
preemptible
low latency
AA's vm changes

with some changes and new diffs 

Major Changes:
Swapoff doesn't pause
SMP now compiles and seems to run ok

I have two other trees as requested

RVR's -rmap vm changes instead of AA

and a pure low latency branch without O(1) 

get them here:
http://kernel.kolivas.net

Please feel free to contact me with feedback,comments and suggestions and please
cc me to ensure I see your email.

Cheers, and enjoy
Con Kolivas
