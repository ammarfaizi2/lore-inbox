Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbSJIQy6>; Wed, 9 Oct 2002 12:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSJIQy6>; Wed, 9 Oct 2002 12:54:58 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:13219 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261844AbSJIQy5>; Wed, 9 Oct 2002 12:54:57 -0400
Subject: Re: Looking for testers with these NICs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua>
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 18:11:02 +0100
Message-Id: <1034183463.2063.70.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 22:31, Denis Vlasenko wrote:
> depca.c

Already done

> ewrk3.c
> lp486e.c
> ni5010.c
> ni65.c
> smc9194.c
> 
> These drivers currently don't compile. I'm fixing them but
> can't test on a live hardware. Anyone?

You may want to merge the 2.4 changes as you go. For lp486e you may just
have to pray, its an unusual 486 onboard ethernet. I know 3 people who
have one, and one (mine) burned out the psu and died

