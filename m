Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSEJKJY>; Fri, 10 May 2002 06:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSEJKJX>; Fri, 10 May 2002 06:09:23 -0400
Received: from www.compushop.co.sz ([196.28.7.66]:30175 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313293AbSEJKJX>; Fri, 10 May 2002 06:09:23 -0400
Date: Fri, 10 May 2002 11:47:10 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] opl3 OSS emulation compile fixes
In-Reply-To: <20020510062333.GA10020@wizard.com>
Message-ID: <Pine.LNX.4.44.0205101146160.6271-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, A Guy Called Tyketto wrote:

> 
>         IMHO, this isn't good. I just gave this a run with 2.5.15, and 
> opl3_oss.c wasn't even touched during compile (either into the kernel or as a 
> module); it's completely passed over. more than likely when inserted with 
> modprobe, OSS emulation would fail from functions not being there. I haven't 
> tried that yet, but this would be my guess..

OSS emulation? Or OPL3 OSS emulation?

-- 
http://function.linuxpower.ca
		

