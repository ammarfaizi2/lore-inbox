Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSCDEce>; Sun, 3 Mar 2002 23:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291340AbSCDEcY>; Sun, 3 Mar 2002 23:32:24 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:32732 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S291333AbSCDEcS>;
	Sun, 3 Mar 2002 23:32:18 -0500
Message-ID: <3C82F8C2.80102@tmsusa.com>
Date: Sun, 03 Mar 2002 20:32:02 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: latency & real-time-ness.
In-Reply-To: <E16hd1T-0005QW-00@the-village.bc.nu> <3C82A702.1030803@candelatech.com> <3C82CA19.9000702@tmsusa.com> <3C82EAD9.8010802@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

>
> I found this patch:
> preempt-kernel-rml-2.4.19-pre2-ac2-1.patch
>
> It applied cleanly...looks like maybe this isn't
> the low-latency patch though now that I look at
> it a little closer.
>
You are correct sir - that is not the low latency
patch, although if you add the lock break patch
to the preempt patch, the results are said to be
similar to the low latency patch...

Joe


