Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUCSXCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUCSXCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:02:21 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13075 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263142AbUCSXCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:02:18 -0500
Date: Fri, 19 Mar 2004 23:42:43 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Martin Wilke <werwolf@unixfreunde.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Temp problems amd xp
Message-ID: <20040319224243.GG14537@alpha.home.local>
References: <pan.2004.03.18.16.06.57.166680@unixfreunde.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.18.16.06.57.166680@unixfreunde.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 05:06:57PM +0100, Martin Wilke wrote:
> just wanna know if somebody has the same problem as me.
> 
> i' m running an amd xp 3000+ on an epox board with nforce2-chipset. everything 
> was alright til i changeed from kernbel 2.6.3 to 2.6.4 3 days ago. since then 
> my cpu-temperature rised to 60-65 degrees, sometimes 73 degrees (while 
> compiling) and pc powered himself down then.

Is it really a problem ? Simply raise the bios temperature limit and it's
OK. My dual XP is between 65 and 75 degrees idle, and goes up to 93 during
intensive compilations, and it's doing very well. Admittedly, you have to
wait a *very* long time after power down to touch the heatsinks, but I don't
need to do that anyway, and I prefer the sound of silence ;-)

Cheers,
Willy

