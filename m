Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSGLQvW>; Fri, 12 Jul 2002 12:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSGLQvV>; Fri, 12 Jul 2002 12:51:21 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:64783 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316668AbSGLQvS>; Fri, 12 Jul 2002 12:51:18 -0400
Date: Fri, 12 Jul 2002 18:54:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: JorgP <jorgp@bartnet.net>, linux-kernel@vger.kernel.org
Subject: Re: What is the most stable kernel to date?
Message-ID: <20020712165402.GP29993@louise.pinerecords.com>
References: <20020712163546.GO29993@louise.pinerecords.com> <Pine.LNX.4.44.0207121046090.3421-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207121046090.3421-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 38 days, 1:09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Has anyone conducted any tests to determine what is the most stable (as in
> > > reliable) kernel available?
> > 
> > There is no such test because there's no way to describe "being stable"
> > in formulas.
> > 
> > You might as well like to stick with a kernel that has worked for you
> > for a long enough time. If you don't need the features of 2.4, go with
> > 2.2-latest.
> 
> Well, about stability: I'm running 2.4.19-rc1-aa2 for some days now, I 
> didn't yet have any problems. My sparc64, meanwhile, is running 2.5.24-ct1, 
> stable for more than a week of uptime yet.

As for me,

$ arch
i686
$ uname -r
2.4.19-pre10-ac2
$ uptime
  6:51pm  up 36 days, 19:14, 19 users,  load average: 0.00, 0.00, 0.00
(config: p2, 2 ide controllers, raid0, 2 network adapters)
--
$ arch 
sparc
$ uname -r
2.4.19-pre10
$ uptime
  6:51pm  up 38 days,  8:46,  7 users,  load average: 0.00, 0.01, 0.00
(config: smp ss10, scsi, raid0, 1 network adapter)

The latter is with my dynamic-nocache patch included.


T.
