Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129521AbQLNOoj>; Thu, 14 Dec 2000 09:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbQLNOo3>; Thu, 14 Dec 2000 09:44:29 -0500
Received: from jalon.able.es ([212.97.163.2]:15754 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129521AbQLNOoY>;
	Thu, 14 Dec 2000 09:44:24 -0500
Date: Thu, 14 Dec 2000 15:13:51 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
Message-ID: <20001214151351.G9662@werewolf.able.es>
In-Reply-To: <20001214112217.A9662@werewolf.able.es> <200012141345.eBEDjrs46412@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200012141345.eBEDjrs46412@aslan.scsiguy.com>; from gibbs@scsiguy.com on Thu, Dec 14, 2000 at 14:45:53 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Dec 2000 14:45:53 Justin T. Gibbs wrote:
> >- The subdir for aic7xxx has not a Makefile, or at least it is not created
> >with the patches for 2.2.18.
> 
> It was supposed to be part of the patches for 2.2.18 (each kernel version
> requires a slightly different Makefile which is why it is not included
> in the main source ball).
> 

My fault. Moved old aic* to aic7xxx.O, patched before untaring so 
aic7xxx/Makefile did not create.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-aa1 #1 SMP Mon Dec 11 21:26:28 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
