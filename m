Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316642AbSE0Oo5>; Mon, 27 May 2002 10:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316641AbSE0Oo4>; Mon, 27 May 2002 10:44:56 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8348 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316640AbSE0Ooz>;
	Mon, 27 May 2002 10:44:55 -0400
Date: Mon, 27 May 2002 09:04:12 +0000
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020527090411.A35@toy.ucw.cz>
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu> <3CEBA2D4.4080804@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jo!

> /proc/cpuinfo for one could be replaced by dropping syslog
> messages at a fixed file in /etc/ during boot - it's static after
> all!.

cpuinfo may change at runtime -- think hot-plugging CPUs.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

