Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbQLNOcR>; Thu, 14 Dec 2000 09:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbQLNOcH>; Thu, 14 Dec 2000 09:32:07 -0500
Received: from jalon.able.es ([212.97.163.2]:61065 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129904AbQLNObv>;
	Thu, 14 Dec 2000 09:31:51 -0500
Date: Thu, 14 Dec 2000 15:01:15 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do NOT compile 2.2.18 with egcs-1.1.2
Message-ID: <20001214150115.E9662@werewolf.able.es>
In-Reply-To: <20001214113813.C9662@werewolf.able.es> <E146Vys-00047u-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E146Vys-00047u-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 11:51:19 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Dec 2000 11:51:19 Alan Cox wrote:
> 
> I have no plan to do this. Don's drivers depend on some extra glue that was
> rejected from the main kernel tree. Said glue is also buggy causing the same
> card to be multiply detected.
> 
> If folks want to strip the glue out and get real changes into the tree or
> clean up a given driver then go ahead. (natsemi and the via-rhine updates
> would be nice for example).
> 

Thanks, will try with the ne2k-pci, which is what I can test. I like mainly
the new full-duplex.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-aa1 #1 SMP Mon Dec 11 21:26:28 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
