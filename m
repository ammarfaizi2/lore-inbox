Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSIOWb5>; Sun, 15 Sep 2002 18:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSIOWb5>; Sun, 15 Sep 2002 18:31:57 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:46008 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S318282AbSIOWbz>;
	Sun, 15 Sep 2002 18:31:55 -0400
Message-ID: <1032129408.3d850b8074a0f@kolivas.net>
Date: Mon, 16 Sep 2002 08:36:48 +1000
From: Con Kolivas <conman@kolivas.net>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Revealing benchmarks and new version of contest.
References: <20020915170622.5444.qmail@linuxmail.org>
In-Reply-To: <20020915170622.5444.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:

> From: Con Kolivas <conman@kolivas.net>
> [...]
> > Below are the new benchmarks with these loads:
> Con, 
> I have different results:
> 

> 2.5.34 is preemption ON
> HW is a HP omnibook6000, 256 MiB RAM, PIII@800

It is clear that different hardware and hardware settings will show up different
areas of weakness. Furthermore, different file systems will affect the load very
differently. This test is just in it's infancy and has already undergone five
revisions in the two days it has existed. It will be interesting to see these
hardware effects, and how the different subsystems affect different areas.

My test machine is also a laptop, 256Mb Ram PIII@1133 and it runs reiserFS

The test is now at version 0.23 with a different mem_load so may show up more
mem differences. V 0.30 will be a code cleanup mainly by Rik.

It now has a homepage:
http://contest.kolivas.net

Con.
