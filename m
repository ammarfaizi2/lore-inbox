Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUIKVQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUIKVQw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUIKVMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:12:54 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:21659 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268323AbUIKVJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:09:46 -0400
Date: Sat, 11 Sep 2004 22:10:24 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Chris Wright <chrisw@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latest microcode data from Intel.
In-Reply-To: <20040910093904.R1973@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0409112208130.1911-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Chris Wright wrote:

> * Tigran Aivazian (tigran@veritas.com) wrote:
> > sense (as it is impossible under Linux to bind userspace app to a given 
> > cpu then there is no "good" sense in which "per cpu" node can be defined).
> 
> sched_setaffinity(2) allows you to bind a userspace app to a given cpu.
> 

Interesting, thank you, I didn't know that it is already possible to do 
this.

Kind regards
Tigran

