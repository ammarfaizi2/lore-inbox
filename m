Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129870AbQLNXmv>; Thu, 14 Dec 2000 18:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129880AbQLNXmk>; Thu, 14 Dec 2000 18:42:40 -0500
Received: from jalon.able.es ([212.97.163.2]:47511 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129870AbQLNXmi>;
	Thu, 14 Dec 2000 18:42:38 -0500
Date: Fri, 15 Dec 2000 00:12:04 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: VM problems still in 2.2.18
Message-ID: <20001215001204.C1331@werewolf.able.es>
In-Reply-To: <20001214210941.A707@middle.of.nowhere> <E146h1W-000081-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E146h1W-000081-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 14, 2000 at 23:38:49 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2000/12/14 Alan Cox wrote:
> > slrnpull --expire on a news-spool of about 600 Mb in 200,000 files gave
> > a lot of 'trying_to_free..' errors.
> > 
> > 2.2.18 + VM-global, booted with mem=32M:
> > 
> > slrnpull --expire on the same spool worked fine.
> 
> I think Andrea just earned his official God status ;)
> 

How about a 2.2.19-pre1 == 2.2.18-aa2 ?

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-aa2 #1 SMP Thu Dec 14 21:22:40 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
