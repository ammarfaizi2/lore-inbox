Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132492AbQLHRt5>; Fri, 8 Dec 2000 12:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132455AbQLHRtr>; Fri, 8 Dec 2000 12:49:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28945 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132492AbQLHRt3>; Fri, 8 Dec 2000 12:49:29 -0500
Subject: Re: Linux 2.2.18pre25
To: M.Kacer@sh.cvut.cz (Martin Kacer)
Date: Fri, 8 Dec 2000 17:20:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        andrea@suse.de (Andrea Arcangeli)
In-Reply-To: <Pine.LNX.4.30.0012081738140.7409-100000@duck.sh.cvut.cz> from "Martin Kacer" at Dec 08, 2000 06:02:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144RCQ-0004Ba-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    We aplied 2.2.18pre25 patch yesterday hoping it could solve it. The
> only difference is that the server reached several hours uptime instead of
> 40 minutes (with pre24). After two hours of load between 6.00 and 15.00
> the console was flooded with those unpopular messages ("VM: ..."). The
> system was taken down by generation of these messages so quickly, that
> even none of the messages appeared in syslog! No response to Ctrl-Alt-Del,
> of course... :-( Just trashing...
> 
>    Our bug can generate them. :-( Maybe it's a different one? ;-)

Quite possibly.

>    Is there any chance to get rid of these VMM failures?

By finding them. Are you confident you are not running out of memory. 
Presumably since 2.2.13 works you are 8)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
