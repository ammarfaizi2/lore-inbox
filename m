Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSGLRQb>; Fri, 12 Jul 2002 13:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSGLRQa>; Fri, 12 Jul 2002 13:16:30 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:38099 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S316674AbSGLRQ3>; Fri, 12 Jul 2002 13:16:29 -0400
Subject: Re: What is the most stable kernel to date?
From: Steven Cole <scole@lanl.gov>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Thunder from the hill <thunder@ngforever.de>, JorgP <jorgp@bartnet.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020712165402.GP29993@louise.pinerecords.com>
References: <20020712163546.GO29993@louise.pinerecords.com>
	<Pine.LNX.4.44.0207121046090.3421-100000@hawkeye.luckynet.adm> 
	<20020712165402.GP29993@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Jul 2002 11:16:23 -0600
Message-Id: <1026494183.2561.151.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 10:54, Tomas Szepe wrote:
> > > > Has anyone conducted any tests to determine what is the most stable (as in
> > > > reliable) kernel available?
> > > 
> > > There is no such test because there's no way to describe "being stable"
> > > in formulas.
> > > 
> > > You might as well like to stick with a kernel that has worked for you
> > > for a long enough time. If you don't need the features of 2.4, go with
> > > 2.2-latest.
> > 
> > Well, about stability: I'm running 2.4.19-rc1-aa2 for some days now, I 
> > didn't yet have any problems. My sparc64, meanwhile, is running 2.5.24-ct1, 
> > stable for more than a week of uptime yet.
> 
> As for me,
> 
> $ arch
> i686
> $ uname -r
> 2.4.19-pre10-ac2
> $ uptime
>   6:51pm  up 36 days, 19:14, 19 users,  load average: 0.00, 0.00, 0.00
> (config: p2, 2 ide controllers, raid0, 2 network adapters)
> --

Even with an early 2.4.x kernel, you can get good results.  I guess it
really depends on your load.

[steven@trenda steven]$ uptime
 11:29am  up 205 days, 23:29,  2 users,  load average: 0.35, 0.14, 0.08
[steven@trenda steven]$ uname -a
Linux trenda.esa.lanl.gov 2.4.1 #1 Tue Jan 30 08:03:20 MST 2001 i586
unknown

This is on an elderly Pentium-90 which ran kernel 0.99 for over a year
once upon a time.

Steven


