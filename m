Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSHXOcj>; Sat, 24 Aug 2002 10:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSHXOcj>; Sat, 24 Aug 2002 10:32:39 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:46530 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S316408AbSHXOcj>;
	Sat, 24 Aug 2002 10:32:39 -0400
Message-ID: <1030199809.3d679a012042b@kolivas.net>
Date: Sun, 25 Aug 2002 00:36:49 +1000
From: conman@kolivas.net
To: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: VM changes added to performance patches for 2.4.19
References: <1030170794.3d6728aa24046@kolivas.net> <E17ibVa-0001Xf-00@starship>
In-Reply-To: <E17ibVa-0001Xf-00@starship>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Phillips <phillips@arcor.de>:
> Would you be so kind as to attempt to quantify that?

Ummm... I'm not sure if you're making fun or me? I haven't done any objective
tests so I can't quantify it ??

I just found the responsiveness of the machine a little better and don't have
the resources, time or inclination to test it with a benchmark. It's my
understanding that the -aa patch performed better on benchmarks, but that some
people reported the responsiveness was better with -rmap anyway. I'd agree with
the latter statement. I offer both patches with mine so if people want to try my
patch and feel strongly either way they can choose. My aim is to optimise system
response for single cpu desktops, not multi cpu servers.

Con.
