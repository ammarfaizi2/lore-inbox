Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbSIXVds>; Tue, 24 Sep 2002 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbSIXVdr>; Tue, 24 Sep 2002 17:33:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60168 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261823AbSIXVdI>; Tue, 24 Sep 2002 17:33:08 -0400
Date: Tue, 24 Sep 2002 17:30:27 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <Pine.LNX.3.95.1020923102813.3315A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1020924172838.19732G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Richard B. Johnson wrote:

> Yes I like that, but does this measure "goodness of the test" or
> something else? To make myself clear, let's look at some ridiculous
> extreme condition. Your test really takes 1 second, but during your
> tests there is a ping-flood that causes your test to take an hour.

If you run in single user mode as suggested that's pretty unlikely. I
would think having the power go off and your laptop drop into power save
slow mode more likely ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

