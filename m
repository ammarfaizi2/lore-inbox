Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318164AbSHIGa0>; Fri, 9 Aug 2002 02:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318167AbSHIGa0>; Fri, 9 Aug 2002 02:30:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42509 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318166AbSHIGaZ>; Fri, 9 Aug 2002 02:30:25 -0400
Message-ID: <3D5360D4.3040702@evision.ag>
Date: Fri, 09 Aug 2002 08:27:32 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Thunder from the hill <thunder@lightweight.ods.org>
CC: martin@dalecki.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ingo Molnar <mingo@elte.hu>, "Adam J. Richter" <adam@yggdrasil.com>,
       Andries.Brouwer@cwi.nl, johninsd@san.rr.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <Pine.LNX.4.44.0208081807180.10270-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Thunder from the hill napisa?:
> Hi,
> 
> On Thu, 2002-08-08 at 13:18, Marcin Dalecki wrote:
> 
>>becouse anything else doesn't make much sense and disks have passed the 
>>512MB or even 4G barrier quite a time ago.
> 
> 
> I have lots of pseudo-diskless hosts. Whereever I didn't want to spend 
> money for a boot PROM, I've grabbed out disks of ~30M, and things worked 
> fine. If things don't, I also have a Busybox on those disks which can be 
> booted instead of the network. They're clients, routers, blah...

They still work becouse then lilo doesn't get confused.

