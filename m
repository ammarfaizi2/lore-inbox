Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSHAUu1>; Thu, 1 Aug 2002 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSHAUtU>; Thu, 1 Aug 2002 16:49:20 -0400
Received: from p50887441.dip.t-dialin.net ([80.136.116.65]:47033 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315455AbSHAUtR>; Thu, 1 Aug 2002 16:49:17 -0400
Date: Thu, 1 Aug 2002 14:52:28 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Miguel A Bolanos <mike@costarica.net>
cc: Shanti Katta <katta@csee.wvu.edu>, <sparclinux@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: what version of gcc can be used to build kernels on Linux/sparc64?
In-Reply-To: <Pine.LNX.4.33.0207301613370.20597-100000@mail.costarica.net>
Message-ID: <Pine.LNX.4.44.0208011448020.5119-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 30 Jul 2002, Miguel A Bolanos wrote:
> Just use egc64 if its only for the kernel, or if you want to for the
> kernel and some packages  use gcc3

Problems:

egcs64:	fails to compile 2.5 for me, because it doesn't support the 
	current syntax
gcc3.1:	1 unexpected failure is not too bad, but 25 unexpected successes 
	aren't too encouraging...

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

