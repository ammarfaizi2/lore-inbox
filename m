Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSJJNKw>; Thu, 10 Oct 2002 09:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbSJJNKw>; Thu, 10 Oct 2002 09:10:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56334 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261375AbSJJNKv>; Thu, 10 Oct 2002 09:10:51 -0400
Date: Thu, 10 Oct 2002 09:08:50 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.41-ac1
Message-ID: <Pine.LNX.3.96.1021010090606.16520E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First 2.5 kernel to build out of the box and run. I haven't tried all the
drivers I can actually use, but at least the base system builds and runs
without patches.

I have a response time benchmark which shows that all 2.5 kernels have a
problem with response time under heavy write/swap load, but I don't have
the docs written for the test, so I probably shouldn't post results from
it ;-) In any case, nice job on this one!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

