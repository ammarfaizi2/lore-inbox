Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSHEHJB>; Mon, 5 Aug 2002 03:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318324AbSHEHJB>; Mon, 5 Aug 2002 03:09:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:12539 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314138AbSHEHJA>; Mon, 5 Aug 2002 03:09:00 -0400
Subject: Re: 2.4.19-ac2 ... file not found worries me
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Clemens 'Gullevek' Schwaighofer" <schwaigl@eunet.at>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <74122858180.20020805073804@eunet.at>
References: <Pine.LNX.4.44.0208041327260.10270-100000@hawkeye.luckynet.adm>
	 <74122858180.20020805073804@eunet.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 09:31:06 +0100
Message-Id: <1028536266.16555.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 06:38, Clemens 'Gullevek' Schwaighofer wrote:
> Hello Thunder, 
> 
> Sunday, August 4, 2002, 9:34:00 PM, Thunder from the hill wrote,
> and I answered on Montag, 05. August 2002, 07:36:30 with this ...
> 
> >> via-pmu.c:40:22: asm/prom.h: No such file or directory
> >> via-pmu.c:41:25: asm/machdep.h: No such file or directory
> >> via-pmu.c:45:26: asm/sections.h: No such file ordirectory
> >> via-pmu.c:48:30: asm/pmac_feature.h: No such file or directory
> >> via-pmu.c:51:26: asm/sections.h: No such file or directory
> >> via-pmu.c:52:26: asm/cputable.h: No such file or directory
> >> via-pmu.c:53:22: asm/time.h: No such file or directory
> 
> > Are you on i386? via-pmu is IMHO a macintosh interface.
> 
> then there has to be some sort of configure error, as in fact I am on

None at all. Its just the wake the dependancy generator works

