Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317384AbSFCOrR>; Mon, 3 Jun 2002 10:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSFCOrQ>; Mon, 3 Jun 2002 10:47:16 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52209 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317384AbSFCOrQ>; Mon, 3 Jun 2002 10:47:16 -0400
Subject: Re: [PATCH] 2.4.19pre9 in pdc202xx.c bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hank Yang <hanky@promise.com.tw>
Cc: andre@linuxdiskcert.org, marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, arjanv@redhat.com,
        Linus Chen <linusc@promise.com.tw>,
        Crimson Hung <crimsonh@promise.com.tw>,
        Jenny Liang <jennyl@promise.com.tw>, jordanr@promise.com
In-Reply-To: <01bd01c20ab1$ece95900$c0cca8c0@promise.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Jun 2002 16:48:28 +0100
Message-Id: <1023119309.3439.79.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 04:51, Hank Yang wrote:
>     There is something wrong in drivers/ide/pdc202xx.c ide driver.
> Andre Hedrick has merged ide stuff to 2.4.18 kernel that released for
> RedHat 7.3, SuSE 8.0 and Mandrake 8.2. That has a bug inside to
> harmful our company.

Item 4 is already done in my tree. As I said before the patch you sent
me a while back did not apply and appeared to be for an old 2.4.17/8
tree. I never got an update beyond that so I had assumed the problem had
already been resolved.

Andre - want to go over the rest and send me the bits ? Or Hank do you
want to send me a patch versus 2.4.19pre to fix those bugs

Alan


