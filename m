Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268959AbRG0USZ>; Fri, 27 Jul 2001 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbRG0USM>; Fri, 27 Jul 2001 16:18:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34060 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268952AbRG0UR6>; Fri, 27 Jul 2001 16:17:58 -0400
Subject: Re: VIA KT133A / athlon / MMX
To: ppeiffer@free.fr (PEIFFER Pierre)
Date: Fri, 27 Jul 2001 21:19:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "PEIFFER Pierre" at Jul 27, 2001 09:42:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QE4v-0006R5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> have not found clear answer on the different threads about this topic.
> As I understand, this problem does not exist on every athlon but only on
> some which work with the VIA KT133 chipset ? Right ?

Its heavily tied to certain motherboards. Some people found a better PSU
fixed it, others that altering memory settings helped. And in many cases,
taking it back and buying a different vendors board worked.

> 	Anyway, feel free to ask me more information if needed and please,
> CC'ed me personally the answers/comments because I'm not subscribed to
> the LKML.

http://www.linuxhardware.org/article.pl?sid=01/06/06/1821202&mode=thread

gives a good feel for the current state of play
