Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKERqJ>; Sun, 5 Nov 2000 12:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129708AbQKERpt>; Sun, 5 Nov 2000 12:45:49 -0500
Received: from pC19F3373.dip.t-dialin.net ([193.159.51.115]:26885 "EHLO
	fmpserver.fmpserver.fmp") by vger.kernel.org with ESMTP
	id <S129121AbQKERps>; Sun, 5 Nov 2000 12:45:48 -0500
Message-ID: <3A059BF6.8E99F434@profmakx.de>
Date: Sun, 05 Nov 2000 18:42:14 +0100
From: Markus <profmakx@profmakx.de>
Reply-To: profmakx@web.de
X-Mailer: Mozilla 4.72 [en]C-CCK-MCD QXW0323l  (Win98; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Dennis <dennis@etinc.com>
CC: umbertogs@uol.com.br, linux-kernel@vger.kernel.org
Subject: Re: trouble with eepro100+catalyst
In-Reply-To: <5.0.0.25.0.20001021123524.02372be0@mail.etinc.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dennis, Your comment isn´t that productive
What about ECN? Have acitivated it (proc/sys/net/ipv4/tcp_ecn, if I remember
correctly)

Markus

Dennis wrote:

> At 11:06 PM 10/20/2000, umbertogs@uol.com.br wrote:
> >We're having lots of trouble with eepro100 and Cisco Catalyst switch,
> >and my net are a vlan. I am using RedHat 6.2/7.0 and not ping to gateway,
> >but with o Slackware 7.0 ok. What's the magic?
> >
> >Regards,
> >
> >Umberto
> >Systems Analyst
> >.comDominio
> >Brazil
>
> Ciscos and catalysts have all kinds of problems connecting to PCs. They
> like to talk to each other mostly. Unfortunately, the widespread propaganda
> that cisco is flawless hinders the true diagnosis in many cases.
>
> get yourself a cheap 10/100 hub or switch and wire it between the units and
> then go watch some sports instead of banging your head for nothing
>
> Sometimes its better to sacrifice performance (ie catalysts) for  something
> that works.
>
> Dennis
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
