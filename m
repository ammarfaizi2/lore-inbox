Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUJIUlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUJIUlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJIUlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:41:14 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:20646
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S267401AbUJIUgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:36:48 -0400
Message-ID: <41684BC1.5000500@ppp0.net>
Date: Sat, 09 Oct 2004 22:36:17 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml@lpbproductions.com
CC: Ed Schouten <ed@il.fontys.nl>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
References: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210> <200410091315.10988.lkml@lpbproductions.com>
In-Reply-To: <200410091315.10988.lkml@lpbproductions.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Heler wrote:
> Why can't theese patches be maintained outside the kernel tree , as it is 
> now ? 
> 
> I'm strongly against this because the X-Box is a gaming platform and last I 
> heard ( and I could be wrong here ) is that you had to hack your X-Box in 
> order to load any other os then the one supplied with it. I just don't see a 
> justified reason why theese patches should be included into the kernel. 
> 

<TrollMode>
Well, Altix is a server platform, last I heard I had to hack my credit
card institute in order to get one.
I suspect there are more people using xbox w/ linux than altix users.
</TrollMode>

Really, Linux already supports so many varieties of hardware used by
only a small number of people. It's just convenient to have it in
mainline and adapted when api changes.

Jan
