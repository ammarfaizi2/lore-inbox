Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132295AbRAaQpY>; Wed, 31 Jan 2001 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132291AbRAaQpO>; Wed, 31 Jan 2001 11:45:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45064 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131234AbRAaQpB>; Wed, 31 Jan 2001 11:45:01 -0500
Subject: Re: hotmail not dealing with ECN
To: tmh@magenta-netlogic.com (Tony Hoyle)
Date: Wed, 31 Jan 2001 16:45:43 +0000 (GMT)
Cc: lmb@suse.de (Lars Marowsky-Bree),
        prandal@herefordshire.gov.uk (Randal Phil),
        linux-kernel@vger.kernel.org ("Linux-Kernel (E-mail)")
In-Reply-To: <3A71B14D.267771A@magenta-netlogic.com> from "Tony Hoyle" at Jan 26, 2001 05:18:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O0O9-0002fK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the UK two of the largest ISPs - BT Internet and Freeserve - have
> ECN-blocking
> firewalls.  So does theregister.co.uk for that matter.  If I enable ECN
> I lose
> the ability to send emails to a huge percentage of the people on the
> mailing lists
> that run on my machine.
> 
> These ISPs will *not* change simply because 1% of Linux users complain

I suspect you do the freeserve guys a great disrespect (they host
ftp.linux.org.uk for one thing). If you've got traces showing what freeserve
stuff is mishandling ECN I'll have a chat with the right people

The Register can probably also be persuaded easily enough (make fun of them
on other sites as they make fun of incompetent IT sites and wait..)

BT well, there are reasons I don't even have a BT telephone line in my house.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
