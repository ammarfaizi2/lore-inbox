Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319331AbSHVMGM>; Thu, 22 Aug 2002 08:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319332AbSHVMGM>; Thu, 22 Aug 2002 08:06:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22788 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S319331AbSHVMGL>; Thu, 22 Aug 2002 08:06:11 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: large page patch (fwd) (fwd)
Date: 22 Aug 2002 12:03:55 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <ak2jvb$61h$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0208130942130.7411-100000@home.transmeta.com> <Pine.LNX.4.44L.0208131425500.23404-100000@imladris.surriel.com>
X-Trace: gatekeeper.tmr.com 1030017835 6193 192.168.12.62 (22 Aug 2002 12:03:55 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44L.0208131425500.23404-100000@imladris.surriel.com>,
Rik van Riel  <riel@conectiva.com.br> wrote:

| Suppose somebody sends you a patch which implements a nice
| algorithm that just happens to be patented by that same
| somebody.  You don't know about the patent.
| 
| You integrate the patch into the kernel and distribute it,
| one year later you get sued by the original contributor of
| that patch because you distribute code that is patented by
| that person.
| 
| Not having some protection in the license could open you
| up to sneaky after-the-fact problems.
| 
| Having a license that explicitly states that people who
| contribute and use Linux shouldn't sue you over it might
| prevent some problems.

Unlikely as this is, since offering the patch would probably be
(eventually) interpreted as giving you the right to use it under GPL, I
think this is a valid concern.

Maybe some lawyer could add the required words and it could become the
LFSL v1.0 (Linux Free Software License). Although FSF would probably buy
into a change if the alternative was creation of a Linux license. There
are people there who are in touch with reality.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
