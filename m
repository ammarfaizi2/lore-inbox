Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266198AbRGOL2Z>; Sun, 15 Jul 2001 07:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266220AbRGOL2P>; Sun, 15 Jul 2001 07:28:15 -0400
Received: from beasley.gator.com ([63.197.87.202]:50700 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266198AbRGOL2E>; Sun, 15 Jul 2001 07:28:04 -0400
From: "George Bonser" <george@gator.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 04:32:32 -0700
Message-ID: <CHEKKPICCNOGICGMDODJGEEPDKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <15185.31680.2839.595301@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It really does not matter all that much to me, I can simply:

echo 128 >/proc/sys/net/ipv4/ip_default_ttl

on every single one of my servers.

But I thought I would "share the wealth" with other admins out there and
have that the kernel default.



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of David S. Miller
> Sent: Sunday, July 15, 2001 4:17 AM
> To: George Bonser
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] Linux default IP ttl
>
>
>
> George Bonser writes:
>  > Only Linux sites ...
>
> Ie. a significant percentage of the net.
>
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

