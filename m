Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbRGOLiQ>; Sun, 15 Jul 2001 07:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbRGOLiH>; Sun, 15 Jul 2001 07:38:07 -0400
Received: from beasley.gator.com ([63.197.87.202]:64524 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266250AbRGOLhy>; Sun, 15 Jul 2001 07:37:54 -0400
From: "George Bonser" <george@gator.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 04:42:23 -0700
Message-ID: <CHEKKPICCNOGICGMDODJKEFADKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <15185.32479.520720.444617@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hehe, hey, its not MY routers/sites that are broken. Look at it this way ...
Microsoft must have figured out that there were some broken nets out there
and that setting a default TTL of 128 made their stuff work.  I also noticed
that setting my TTL to 128 made my stuff work.  I am not in any kind of
crusade to make people do "the right thing". I am simply trying to make my
site work with the maximum number of possible clients.

I really do not care WHY it works, all I care is that it DOES work. I am not
the least bit interested given the current economy of things to try to bully
people into doing what is right. I am more interested in operating with the
client population that is out there without having to make them change
anything.



> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: Sunday, July 15, 2001 4:31 AM
> To: George Bonser
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] Linux default IP ttl
>
>
>
> George Bonser writes:
>  > But I thought I would "share the wealth" with other admins out
> there and
>  > have that the kernel default.
>
> How about "sharing the wealth" with the broken sites/routers insteaad?
>
> Later,
> David S. Miller
> davem@redhat.com

