Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSHGB4y>; Tue, 6 Aug 2002 21:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSHGB4y>; Tue, 6 Aug 2002 21:56:54 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15888 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316898AbSHGB4x>; Tue, 6 Aug 2002 21:56:53 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux v2.4.19
Date: 7 Aug 2002 01:54:33 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <aipukp$9bg$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.21.0208032156330.29654-100000@www2.jubileegroup.co.uk> <1028413405.1761.38.camel@irongate.swansea.linux.org.uk>
X-Trace: gatekeeper.tmr.com 1028685273 9584 192.168.12.62 (7 Aug 2002 01:54:33 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1028413405.1761.38.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
| On Sat, 2002-08-03 at 22:00, Ged Haywood wrote:
| > Hi there,
| > 
| > On Sat, 3 Aug 2002, Mr. James W. Laferriere wrote:
| > 
| > > Haven't the tarballs usuaully been archived as 'linux/' instead of
| > > 'linux-2.4.19/' ?
| > 
| > Absolutely not.  Many systems have a symlink 'linux' to the current
| > kernel tree, which is a directory e.g. 'linux-2.2.16'.  If the tarball
| 
| Kernels until recently did always unpack into linux/. Linus changed and
| I'm happy Marcelo has followed suit, its much more sensible the new way

Let's hope the major fix trees like -aa and -ac follow the convention. I
have no problem with the change (since I keep my stuff that way) but I
hope it is pervasive.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
