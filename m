Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSIBFf6>; Mon, 2 Sep 2002 01:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSIBFf6>; Mon, 2 Sep 2002 01:35:58 -0400
Received: from flrtn-5-m1-95.vnnyca.adelphia.net ([24.55.70.95]:11656 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S317359AbSIBFf5>;
	Mon, 2 Sep 2002 01:35:57 -0400
Message-ID: <3D72F9C8.5090506@tmsusa.com>
Date: Sun, 01 Sep 2002 22:40:24 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul <set@pobox.com>
CC: linux-kernel@vger.kernel.org, conman@kolivas.net
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
References: <3D72C6F9.6000302@wmich.edu> <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com> <20020902052203.GC2925@squish.home.loc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ck5 kernel comes in more than one flavor

rmap, aa and low latency are offered -

I'm running 2.4.19-ck5-ll and I'm happy to report
that it also plays well with freeswan ipsec - I'm
running freeswan 1.98b and it's all good - not to
mention the nice smooth feel in multimedia and
3D fps shooters ;-)

Thanks to conman for the tedious patching work!

Joe

Paul wrote:

>ps. ck4 uses the aa vm, but if there was a version with rmap,
>I would test it
>

