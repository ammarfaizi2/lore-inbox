Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283566AbRK3IfO>; Fri, 30 Nov 2001 03:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283559AbRK3IfE>; Fri, 30 Nov 2001 03:35:04 -0500
Received: from frosch.logivision.de ([212.42.242.2]:14354 "EHLO
	frosch.logivision.net") by vger.kernel.org with ESMTP
	id <S283563AbRK3Iet> convert rfc822-to-8bit; Fri, 30 Nov 2001 03:34:49 -0500
Apparently-To: <linux-kernel@vger.kernel.org>
From: Frank Eichentopf <frei@hap-bb.de>
Date: Fri, 30 Nov 2001 08:34:47 GMT
Message-ID: <20011130.8344700@batnator.hap.de>
Subject: Re: DLink DGE500SX support???
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0111292011190.9040-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0111292011190.9040-100000@mustard.heime.net>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes there is support, the driver for linux 2.2.x is shipped
with the card, but this driver will not work under linux 2.4.x.
i use the jt1lin driver for the levelone lxt1001 chipset on
this card under linux 2.4.0 up to 2.4.13 and the card is working
fine. (SMP 2x266, 512MB RAM, 10GB RAID5)
you can download this driver under follwing url:

http://www.hap-bb.de/linux/jt1lin.tar.gz

is there anyone who can implement this driver in the offical
kerneltree? (i'm not the great kernelhacker)

greetings frank

    .--.
   |o_o |      Frank Eichentopf
   |:_/ |         HaP Buerotechnik
  //   \ \        Ebertystr. 7
 (|     | )       10249 Berlin
/'\_   _/`\       frei@hap-bb.de
\___)=(___/       +49 30 420 267 016



>>>>>>>>>>>>>>>>>> Ursprüngliche Nachricht <<<<<<<<<<<<<<<<<<

Am 29.11.01, 20:12:36, schrieb Roy Sigurd Karlsbakk <roy@karlsbakk.net> zum 
Thema DLink DGE500SX support???:


> hi all

> Are there any support for the DLink DGE500SX card? See
> 
http://www.shipitforyou.com/cgi-bin/sgin0105.exe?TRAN85=Y&UID=200111291109
2221&T1=D100+1200&FNM=74
> for more info...

> thanks

> roy

> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

> Computers are like air conditioners.
> They stop working when you open Windows.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
