Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135763AbRAJU7r>; Wed, 10 Jan 2001 15:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131105AbRAJU7h>; Wed, 10 Jan 2001 15:59:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54533 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135944AbRAJU7S>; Wed, 10 Jan 2001 15:59:18 -0500
Subject: Re: 2.4 patch branch
To: jamagallon@able.es (J . A . Magallon)
Date: Wed, 10 Jan 2001 21:00:59 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010110215505.A864@werewolf.able.es> from "J . A . Magallon" at Jan 10, 2001 09:55:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GSMm-0000xv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the relationship betwwen 2.4.1-pre1 and Alan's ac5 ?
> As I see dates over ftp, ac5 is newer than pre1 (and bigger...)
> Is the next step a pre1-ac1 ?

I merged Linus pre1. I will go over the diffs between the two and send Linus
any critical stuff I've not yet sent him soon.

I'm trying to provide a rolling platform for debugging, Linus is trying to 
provide a rock solid kernel. The two things converge but not yet

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
