Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133066AbQLOBBs>; Thu, 14 Dec 2000 20:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132829AbQLOBBi>; Thu, 14 Dec 2000 20:01:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64004 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132654AbQLOBBZ>; Thu, 14 Dec 2000 20:01:25 -0500
Subject: Re: Linus's include file strategy redux
To: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Date: Fri, 15 Dec 2000 00:33:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <91bnoc$vij$2@enterprise.cistron.net> from "Miquel van Smoorenburg" at Dec 15, 2000 12:14:04 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146iof-0000OI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Which works because in a normal compile environment they have /usr/include
> >in their include path and /usr/include/linux points to the directory
> >under /usr/src/linux/include.
> 
> No, that a redhat-ism.

Umm, its a most people except Debianism. People relied on it despite it
being wrong. RH7 ships with a matching library set of headers. I got to close
a lot of bug reports explaining to people that the new setup was in fact
right 8(

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
