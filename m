Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUELXew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUELXew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUELXew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:34:52 -0400
Received: from [80.72.36.106] ([80.72.36.106]:57763 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S263191AbUELXeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:34:50 -0400
Date: Thu, 13 May 2004 01:34:46 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird cold boot problems with Abit KT7 motherboard
In-Reply-To: <Pine.LNX.4.58.0405121815120.2967@marabou.research.att.com>
Message-ID: <Pine.LNX.4.58.0405130126560.19840@alpha.polcom.net>
References: <Pine.LNX.4.58.0405121815120.2967@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Pavel Roskin wrote:

> Hello!
> 
> I have noticed several anomalies with Abit KT7 motherboard.  They all
> happen after power on.  First reboot from Linux (using the reboot command
> or reset button) usually fixes all the problems.  Sometimes two or three
> resets are needed before the motherboard starts working properly.  In two
> cases (of about 20) the motherboard started working properly right after
> powering up.
> 
> [...]

Can you test your machine in both bad and good state with memtest86 for 
few hours? (It is included for example in latest Gentoo live cd). What 
about other cpu and memory intensive benchmarks? (Can you do 3 or 5 
[depending on memory amount] simulateus full botstraps of gcc 3 without 
problems or compile full Gentoo unstable on it? - the best benchmarks I 
know of.)


Grzegorz Kulewski

