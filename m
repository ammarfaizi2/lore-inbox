Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbQLNXpm>; Thu, 14 Dec 2000 18:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLNXp1>; Thu, 14 Dec 2000 18:45:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16132 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129880AbQLNXpG>; Thu, 14 Dec 2000 18:45:06 -0500
Subject: Re: [lkml]Re: VM problems still in 2.2.18
To: jjs@toyota.com (J Sloan)
Date: Thu, 14 Dec 2000 23:17:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <3A394C2F.C2895995@toyota.com> from "J Sloan" at Dec 14, 2000 02:39:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146hcf-0000DG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think Andrea just earned his official God status ;)
> So, maybe his divine VM patches will make it into 2.2.19?

The question is merely 'in what form' . I wanted to keep them seperate from
the other large changes in 2.2.18 for obvious reasons.

Andrea - can we have the core VM changes you did without adopting the
change in semaphore semantics for file system locking which will give third 
party fs maintainers headaches and doesnt match 2.4 behaviour either ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
