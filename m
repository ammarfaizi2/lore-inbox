Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSHAT0M>; Thu, 1 Aug 2002 15:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSHAT0M>; Thu, 1 Aug 2002 15:26:12 -0400
Received: from p50887441.dip.t-dialin.net ([80.136.116.65]:10169 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316860AbSHAT0L>; Thu, 1 Aug 2002 15:26:11 -0400
Date: Thu, 1 Aug 2002 13:29:17 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alexander Viro <viro@math.psu.edu>
cc: Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       <Matt_Domsch@Dell.com>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.28 and partitions
In-Reply-To: <Pine.GSO.4.21.0207311832270.8505-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0208011328240.5119-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Jul 2002, Alexander Viro wrote:
> What the bleedin' hell is wrong with <name> <start> <len>\n - all in ASCII?  
> Terminated by \0.  No need for flags, no need for endianness crap, no
> need to worry about field becoming too narrow...

Well, why not long[] fields? Might be more powerful, and possibly not any 
slower than ASCII.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

