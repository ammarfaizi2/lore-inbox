Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSIBESn>; Mon, 2 Sep 2002 00:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSIBESn>; Mon, 2 Sep 2002 00:18:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318222AbSIBESm> convert rfc822-to-8bit;
	Mon, 2 Sep 2002 00:18:42 -0400
Date: Sun, 1 Sep 2002 21:21:54 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Con Kolivas <conman@kolivas.net>
cc: =?ISO-8859-1?B?RGlldGVyIE78dHplbA==?= <Dieter.Nuetzel@hamburg.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
In-Reply-To: <1030938156.3d72de2c231ac@kolivas.net>
Message-ID: <Pine.LNX.4.33L2.0209012116120.22470-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002, Con Kolivas wrote:

| Quoting Dieter Nützel <Dieter.Nuetzel@hamburg.de>:

snippage...

| > Then I try dbench (Yes, I know Rik ;-) to see the GREAT speed of Andrea
| > Arcangeli's -AA VM which improve noticeably with the Preemption patch.
| > O(1) gave some additional speed, too.
|
| Yes, dbench is included in the many tests available at the the Open Source
| Development Lab (osdl.org) along with many others.

That makes it good, right?  8;)

Actually we are going thru our workloads and trying to
identify what they measure, what they are good for, etc.,
so if you have feedback in this area, please give it to us,
for the workloads that we run on each new kernel (2.5.x
or 2.4.x-marcelo).

-- 
~Randy

