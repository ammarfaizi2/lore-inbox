Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318071AbSHHXyO>; Thu, 8 Aug 2002 19:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSHHXyO>; Thu, 8 Aug 2002 19:54:14 -0400
Received: from pD9E23ABF.dip.t-dialin.net ([217.226.58.191]:3818 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318071AbSHHXyN>; Thu, 8 Aug 2002 19:54:13 -0400
Date: Thu, 8 Aug 2002 17:57:32 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Peter Samuelson <peter@cadcamlab.org>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <linux-kbuild@lists.sourceforge.net>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
In-Reply-To: <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0208081757020.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2002, Kai Germaschewski wrote:
> As you're hacking Configure anyway, what about "fixing"
> 
> 	dep_tristate ' ..' CONFIG_FOO $CONFIG_BAR,
> 
> which doesn't work as expected when CONFIG_BAR is not set (as opposed to 
> "n"), to consider an unset CONFIG_BAR equivalent to "n" in this case?
> 
> (The rather hacky way I'd imagine to do so is to look at all used 
> $CONFIG_* in a Config.in file before sourcing it and setting them to "n")

Hyphenation might help you to see that there has actually been 
something...

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

