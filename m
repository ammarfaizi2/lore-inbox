Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263473AbRFANB1>; Fri, 1 Jun 2001 09:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263493AbRFANBR>; Fri, 1 Jun 2001 09:01:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11271 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263473AbRFANBJ>; Fri, 1 Jun 2001 09:01:09 -0400
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for realthis
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Fri, 1 Jun 2001 13:58:58 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B1790FB.82FC9251@mandrakesoft.com> from "Jeff Garzik" at Jun 01, 2001 08:56:27 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155oW2-0000Ta-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only some of them can be cached...  (some of the MIIs in some drivers
> are already cached, in fact)   you can't cache stuff like what your link
> partner is advertising at the moment, or what your battery status is at
> the moment.

I am sure that to an unpriviledged application reporting back the same result
as we saw last time we asked the hardware unless it is over 30 seconds old
will work fine. Maybe 10 for link partner ?

