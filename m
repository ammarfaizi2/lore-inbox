Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266016AbRGOKNf>; Sun, 15 Jul 2001 06:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266040AbRGOKN0>; Sun, 15 Jul 2001 06:13:26 -0400
Received: from beasley.gator.com ([63.197.87.202]:55051 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S266016AbRGOKNJ>; Sun, 15 Jul 2001 06:13:09 -0400
From: "George Bonser" <george@gator.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
Date: Sun, 15 Jul 2001 03:17:37 -0700
Message-ID: <CHEKKPICCNOGICGMDODJKEEKDKAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <15185.27251.356109.500135@pizda.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why are there 64 friggin hops between machine in your server farm?
> That is what I want to know.  It makes no sense, even over today's
> internet, to have more than 64 hops between two sites.
>
> Later,
> David S. Miller
> davem@redhat.com

I have NO idea and feel the same way. Some of the clients might be buried in
some net inside India or China or the US some other place with some goofy
internal net .. I dunno.  All I know is that MicroSquish set their default
TTL to 128 and there APPEAR to be people reaching me that are more than 64
hops away that are in fact reachable when I increase the TTL.


