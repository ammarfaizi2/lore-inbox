Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTJ0Vxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbTJ0Vxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:53:44 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:47232
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263600AbTJ0Vxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:53:43 -0500
Date: Mon, 27 Oct 2003 16:53:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Yaoping Ruan <yruan@CS.Princeton.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo & top
In-Reply-To: <Pine.LNX.4.58.0310221233040.14330@opus.cs.princeton.edu>
Message-ID: <Pine.LNX.4.53.0310271652020.21953@montezuma.fsmlabs.com>
References: <5.1.0.14.2.20031022014409.00bd4aa0@hesiod>
 <Pine.LNX.4.58.0310221233040.14330@opus.cs.princeton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Yaoping Ruan wrote:

> Hi,
> 
> I compiled 2.4.21 kernel with SMP and High-MEM enabled on a dual-CPU box,
> but surprised to see there're 4 CPUs in /proc/cpuinfo and top. But
> /proc/cpuinfo is correct if SMP is disable during kernel configuration.
> Did anybody experience this before?

Pretty much an FAQ by now, but here it is from the horse's mouth;

http://www.intel.com/products/ht/hyperthreading_more.htm
http://www.intel.com/products/ht/hyperthreading.htm?iid=ipp_htm+ht&
