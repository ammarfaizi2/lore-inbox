Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSELOu1>; Sun, 12 May 2002 10:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSELOu0>; Sun, 12 May 2002 10:50:26 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:36010 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S313558AbSELOuZ>; Sun, 12 May 2002 10:50:25 -0400
Date: Sun, 12 May 2002 06:50:29 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac2
Message-ID: <20020512065029.A25307@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sched.c: In function `migration_thread':
> sched.c:1595: structure has no member named `thread_info'

I see that too when CONFIG_SMP=y.
-- 
Randy Hron

