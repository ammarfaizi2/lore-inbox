Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSIBJHk>; Mon, 2 Sep 2002 05:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSIBJHk>; Mon, 2 Sep 2002 05:07:40 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:29892 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S318237AbSIBJHj>;
	Mon, 2 Sep 2002 05:07:39 -0400
Message-ID: <1030957927.3d732b67b0257@kolivas.net>
Date: Mon,  2 Sep 2002 19:12:07 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Paul <set@pobox.com>
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting J Sloan <joe@tmsusa.com>:

> The ck5 kernel comes in more than one flavor
> 
> rmap, aa and low latency are offered -
> 
> I'm running 2.4.19-ck5-ll and I'm happy to report
> that it also plays well with freeswan ipsec - I'm
> running freeswan 1.98b and it's all good - not to
> mention the nice smooth feel in multimedia and
> 3D fps shooters ;-)
> 
> Thanks to conman for the tedious patching work!
> 
> Joe
> 
> Paul wrote:
> 
> >ps. ck4 uses the aa vm, but if there was a version with rmap,
> >I would test it


Actually Paul was correct; the low latency branch was just -aa but in my never
ending descent into madness I have decided to add another branch as requested,
ck5-rl which has lowest latency with -rmap instead of -aa

Get it at the usual place:
http://kernel.kolivas.net

Con.

P.S. You're welcome Joe.


