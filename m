Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSKCO2U>; Sun, 3 Nov 2002 09:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSKCO2U>; Sun, 3 Nov 2002 09:28:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56069 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261945AbSKCO2S>; Sun, 3 Nov 2002 09:28:18 -0500
Date: Sun, 3 Nov 2002 09:33:52 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Matt D. Robinson" <yakker@aparity.com>, Steven King <sxking@qwest.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <1036288145.18461.13.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021103092330.5197D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Nov 2002, Alan Cox wrote:

> I would hope IBM have more intelligence than to attempt to destroy the
> product by trying to force all sorts of junk into it. The Linux world
> has a process for filterng crap, it isnt IBM applying force. That path
> leads to Star Office 5.2, Netscape 4 and other similar scales of horror
> code that become unmaintainably bad.

If you define "unmaintainably bad" as "having features you don't need"
then I agree. But since dump to disk is in almost every other commercial
UNIX, maybe someone would question why it's good for others but not for
Linux.

I can agree on stuff the non-hacker wouldn't use, but that is exactly who
uses the crash dump in AIX, the person who wants to send a compressed dump
and money to IBM and get back a fix. Netdump assumes external resources
and a functional secure network (is the dump encrypted and I missed it?)
which home users surely don't have, and remote servers oftem lack as well.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

