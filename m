Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSL1U24>; Sat, 28 Dec 2002 15:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSL1U24>; Sat, 28 Dec 2002 15:28:56 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:15356 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S265587AbSL1U24>; Sat, 28 Dec 2002 15:28:56 -0500
Date: Sat, 28 Dec 2002 22:37:06 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021228203706.GD1258@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <200212090830.gB98USW05593@flux.loup.net> <at2l1t$g5n$1@penguin.transmeta.com> <20021209193649.GC10316@suse.de> <at2rv7$fkr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at2rv7$fkr$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 11:46:47AM -0800, you [H. Peter Anvin] wrote:
> 
> SYSCALL is AMD.  SYSENTER is Intel, and is likely to be significantly

Now that Linus has killed the dragon and everybody seems happy with the
shiny new SYSENTER code, let just add one more stupid question to this
thread: has anyone made benchmarks on SYSCALL/SYSENTER/INT80 on Athlon? Is
SYSCALL worth doing separately for Athlon (and perhaps Hammer/32-bit mode)?


-- v --

v@iki.fi
