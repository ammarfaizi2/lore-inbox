Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLNXHc>; Thu, 14 Dec 2000 18:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133089AbQLNXHX>; Thu, 14 Dec 2000 18:07:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:772 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129773AbQLNXHG>; Thu, 14 Dec 2000 18:07:06 -0500
Subject: Re: [lkml]Re: VM problems still in 2.2.18
To: thunder7@xs4all.nl
Date: Thu, 14 Dec 2000 22:38:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001214210941.A707@middle.of.nowhere> from "thunder7@xs4all.nl" at Dec 14, 2000 09:09:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146h1W-000081-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> slrnpull --expire on a news-spool of about 600 Mb in 200,000 files gave
> a lot of 'trying_to_free..' errors.
> 
> 2.2.18 + VM-global, booted with mem=32M:
> 
> slrnpull --expire on the same spool worked fine.

I think Andrea just earned his official God status ;)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
