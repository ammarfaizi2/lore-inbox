Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314505AbSD0UeZ>; Sat, 27 Apr 2002 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314512AbSD0UeY>; Sat, 27 Apr 2002 16:34:24 -0400
Received: from proxyserver.epcnet.de ([62.132.156.25]:784 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S314505AbSD0UeY>; Sat, 27 Apr 2002 16:34:24 -0400
Date: Sat, 27 Apr 2002 22:34:09 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <877576231.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020425.174659.107189291.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.8
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 26.04.2002 02:57
>
> BTW, your mail client's mangling of subject lines is REALLY ANNOYING.

Sorry, i fixed it.
 
> We don't call it NETIF_F_VLAN because the hope is that eventually
> it will be rare for a network device to not be able to support it.
> Not the other day around.

I don't know how many cards won't support VLAN nowadays. But i will test
these changes with my third party driver (just recompile it against pre-2.4.19)
and report the results.

Greetings

     Jochen Dolze

