Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQLKLP4>; Mon, 11 Dec 2000 06:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLKLPr>; Mon, 11 Dec 2000 06:15:47 -0500
Received: from [151.17.201.167] ([151.17.201.167]:19992 "EHLO proxy.teamfab.it")
	by vger.kernel.org with ESMTP id <S129511AbQLKLPh>;
	Mon, 11 Dec 2000 06:15:37 -0500
Message-ID: <3A34B014.B72470A@teamfab.it>
Date: Mon, 11 Dec 2000 11:44:36 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.72C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eddy <edmc@snowline.net>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 almost...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> did we lose ip=autoconf. I see dhcp and arp transmitting infinitely. I was 
> able to boot only after completely entering nfsroot= and ip= boot commands.
>
> 2.2.17 worked thusley. 
:

I didn't try with 2.2.18 yet but looking at the source (ipconfig.c)
seem that my patch wasn't accepted, you can give it a try :

http://boudicca.tux.org/hypermail/linux-kernel/2000week48/0213.html

hope this help,
luca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
