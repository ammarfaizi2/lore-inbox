Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267217AbSLKRCy>; Wed, 11 Dec 2002 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbSLKRCy>; Wed, 11 Dec 2002 12:02:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58642 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267217AbSLKRCx>; Wed, 11 Dec 2002 12:02:53 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: how do you successful compile or install 2.5.50?
Date: 11 Dec 2002 17:09:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <at7rfi$iiv$1@gatekeeper.tmr.com>
References: <3DF5EC8E.9050603@centurytel.net>
X-Trace: gatekeeper.tmr.com 1039626547 19039 192.168.12.62 (11 Dec 2002 17:09:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3DF5EC8E.9050603@centurytel.net>,
eric lin  <fsshl@centurytel.net> wrote:

|    I also download from kernel.org 2.5.50, it have error at make modules 
| or make install


|    highly appreciate your experience on compile or install new kernel 
| especailly experiamental kernel


I highly commend disabling module support and building everything
directly in the kernel. If you get this working you can visit the list
archives and read about modules after 2.5.47, and decide if you really
need modules in 2.5 kernels, and what to change if you do.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
