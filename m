Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUBEUjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUBEUjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:39:00 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62641 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266682AbUBEUim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:38:42 -0500
Date: Thu, 5 Feb 2004 21:38:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040205203840.GA13114@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402051517.37466.murilo_pontes@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402051517.37466.murilo_pontes@yahoo.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 05:24:27PM +0000, Murilo Pontes wrote:
> I have same problems since of 2.6.0, now I running 2.6.2 stock kernel
> I run XFree86-4.3.0 and still with problems, anyone try XFree86-4.4.0 devel snapshots???
> 
> I try kernel with/without  preempty/acpi/apic make all possibilities, 
> then may be error is not in kernel, but in XFree86-4.3.0 which not support big changes in input system
> of 2.6.x, I tried compile XFree86 with linux-2.6.{0,1,2} kernel headers was 100% fail, sounds binary 
> and source incompatibilites,  

Hey, guys, could you possibly try to figure out what your machines have
in common? I've switched all my computers to PS/2 mice so that I have a
bigger chance to reproduce the problem, but it is not happening on any
of them.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
