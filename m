Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318092AbSHIAIe>; Thu, 8 Aug 2002 20:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318100AbSHIAId>; Thu, 8 Aug 2002 20:08:33 -0400
Received: from pD9E23ABF.dip.t-dialin.net ([217.226.58.191]:10218 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318092AbSHIAId>; Thu, 8 Aug 2002 20:08:33 -0400
Date: Thu, 8 Aug 2002 18:11:42 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: martin@dalecki.de
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       "Adam J. Richter" <adam@yggdrasil.com>, <Andries.Brouwer@cwi.nl>,
       <johninsd@san.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
In-Reply-To: <20020808181100Z315277-685+26763@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0208081807180.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2002-08-08 at 13:18, Marcin Dalecki wrote:
> becouse anything else doesn't make much sense and disks have passed the 
> 512MB or even 4G barrier quite a time ago.

I have lots of pseudo-diskless hosts. Whereever I didn't want to spend 
money for a boot PROM, I've grabbed out disks of ~30M, and things worked 
fine. If things don't, I also have a Busybox on those disks which can be 
booted instead of the network. They're clients, routers, blah...

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

