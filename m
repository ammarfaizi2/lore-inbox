Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136070AbRA1BuJ>; Sat, 27 Jan 2001 20:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136127AbRA1Bt7>; Sat, 27 Jan 2001 20:49:59 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:19081 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S136070AbRA1Btu>; Sat, 27 Jan 2001 20:49:50 -0500
Date: Sun, 28 Jan 2001 01:53:10 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: routing between different subnets on same if.
In-Reply-To: <94vkr1$p4k$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.31.0101280146450.2119-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, Miquel van Smoorenburg wrote:

> What about /proc/sys/net/ipv4/conf/*/rp_filter ? Should be zero
> for the 192.* interface(s), I think.
>

i already have that enabled for security purposes helaas.

> Mike.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
DISCLAIMER:
Use of this advanced computing technology does not imply an endorsement
of Western industrial civilization.

PS miquel, bitbucket will jouw email niet accepteren, komt terug met
error "550 <miquels@traveler.cistron-office.nl>... Domain has
no existing recipients"


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
