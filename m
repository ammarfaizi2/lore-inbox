Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWH1NET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWH1NET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 09:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWH1NET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 09:04:19 -0400
Received: from mail11.bluewin.ch ([195.186.18.61]:17918 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S1750770AbWH1NES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 09:04:18 -0400
Date: Mon, 28 Aug 2006 15:04:05 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060828130405.GB10557@k3.hellgate.ch>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
X-Operating-System: Linux 2.6.18-rc2-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 21:30:50 -0700, Linus Torvalds wrote:
> Roger Luethi:
>       via-rhine: NAPI support
>       via-rhine: add option avoid_D3 (work around broken BIOSes)
> [...]
> Stephen Hemminger:
>       via-rhine: NAPI poll enable

For the record: Stephen Hemminger wrote the NAPI support for via-rhine, all
I did was point out a minor bug which he fixed promptly.

Roger
