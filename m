Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSGVK7d>; Mon, 22 Jul 2002 06:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSGVK7c>; Mon, 22 Jul 2002 06:59:32 -0400
Received: from mikrolahti.fi ([195.237.35.128]:21253 "EHLO pleco.mikrolahti.fi")
	by vger.kernel.org with ESMTP id <S316728AbSGVK7a>;
	Mon, 22 Jul 2002 06:59:30 -0400
Date: Mon, 22 Jul 2002 14:02:37 +0300
To: Thunder from the hill <thunder@ngforever.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: still troubles with an Alpha-kernel
Message-ID: <20020722110237.GA12719@pleco.mikrolahti.fi>
References: <20020722073941.GA10979@pleco.mikrolahti.fi> <Pine.LNX.4.44.0207220439220.3309-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0207220439220.3309-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
From: samppa@pleco.mikrolahti.fi (Sami Louko)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 04:40:23AM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Mon, 22 Jul 2002, Sami Louko wrote:
> > -r--------    1 root     root         4.0T heinä  22 10:38 /proc/kcore
> > 
> > The core shows a bit huge :-/ Four terabytes... huh.
> 
> Mine (2.4.19-rc2-aa1) is 2 Giga, exactly the RAM size, here...

I wasn't able to compile 2.4.19-rc1-aa2, i should to try compile the
same kernel you have.
I would like to know is it possible to manually fix the size of kcore,
because i do have 512MB mem, not 4080GB, anybody doesn't have that much. =)

I just notified, an errormessage that shows at boot-time, got it from log,

	Jul 22 09:07:55 mikrolahti kernel: Error seeking in /dev/kmem

What may be wrong??!

--sl
