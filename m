Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRELHvT>; Sat, 12 May 2001 03:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261199AbRELHvJ>; Sat, 12 May 2001 03:51:09 -0400
Received: from jalon.able.es ([212.97.163.2]:7403 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S261198AbRELHvF>;
	Sat, 12 May 2001 03:51:05 -0400
Date: Sat, 12 May 2001 09:50:57 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "David S . Miller" <davem@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new version of singlecopy pipe
Message-ID: <20010512095057.A2539@werewolf.able.es>
In-Reply-To: <3AFC36BA.B71FC470@colorfullife.com> <20010512020742.A1054@werewolf.able.es> <15100.33537.982370.753962@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <15100.33537.982370.753962@pizda.ninka.net>; from davem@redhat.com on Sat, May 12, 2001 at 02:25:37 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.12 David S. Miller wrote:
> 
> J . A . Magallon writes:
>  > I tried your patch on 2.4.4-ac8, and something strange happens.
>  > Untarring linux-2.4.4 takes a little time, disk light flashes,
>  > but no files appear on the disk (just 'Makefile', as you will see below).
>  > Doing a separate gunzip - tar xf works fine:
> 
> What platform?
> 

Mandrake 8.1 Cooker. Dual PII@400, 440BX, 256Mb. One aic7890 under Gibbs driver.
gcc 2.96-0.50mdk (matches 84-redhat).

Any more info ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac8 #1 SMP Sat May 12 01:16:37 CEST 2001 i686

