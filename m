Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135336AbRD3PFO>; Mon, 30 Apr 2001 11:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135346AbRD3PFF>; Mon, 30 Apr 2001 11:05:05 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:33800
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S135336AbRD3PEx>; Mon, 30 Apr 2001 11:04:53 -0400
Date: Mon, 30 Apr 2001 08:04:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eirik Overby <ltning@anduin.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x SMP issues on 440LX (?)
Message-ID: <20010430080408.B18828@opus.bloom.county>
In-Reply-To: <20010430062932Z133116-409+1416@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010430062932Z133116-409+1416@vger.kernel.org>; from ltning@anduin.net on Mon, Apr 30, 2001 at 08:29:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 08:29:40AM +0100, Eirik Overby wrote:

> As another person (Aaron M. Folmsbee, 28.04.01-22:32) in here reported 
> earlier, there seems to be problems 
> with Intel 440LX chipsets with dual CPU's and the Linux 2.4 kernel series.
> Simply stated, this just plain doesn't work right. When sticking in only one 
> CPU, the system boots fine, but I 
> see "random" hangs and kernel panics. Watching boot messages and doing a cat 
> /proc/cpuinfo gives the 
> correct information; I have one Intel Pentium II installed.
> However, when sticking in both CPU's, one of two things happen:

What Mobo/CPUs?  I have a Tyan Tiger SD1692DL (I _think_ that's the model, I
haven't checked in ages tho) with 2 P2/333 (Deschutes).  2.4.0,2.4.1,2.4.2 and
2.4.3-pre3 (reiserfs patches) have worked great for me.  2.4.3-pre3 was
up for 16days before I rebooted into 2.4.4 (and power killed another 10+ day
uptime).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
