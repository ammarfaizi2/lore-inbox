Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbTGEUOF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbTGEUOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:14:05 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:42631 "EHLO server")
	by vger.kernel.org with ESMTP id S266473AbTGEUNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:13:53 -0400
Message-ID: <1aa601c34333$fa82e020$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>,
       linux-kernel@vger.kernel.org
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com> <01b101c340dc$ede386c0$3300a8c0@Slepetys> <016901c34191$14c4a1c0$3300a8c0@Slepetys> <13e101c3419d$f62f9410$3400a8c0@W2RZ8L4S02> <01f101c3419f$e6d30360$3300a8c0@Slepetys> <913060000.1057267206@aslan.btc.adaptec.com> <14a301c341b7$7ff0bd50$3400a8c0@W2RZ8L4S02> <2268760000.1057436124@aslan.scsiguy.com>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Sat, 5 Jul 2003 13:28:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the problem is elsewhere, please take a look at this message I sent
earlier.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105742280413809&w=2

----- Original Message ----- 
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "Jim Gifford" <maillist@jg555.com>; "Roberto Slepetys Ferreira"
<slepetys@homeworks.com.br>; <linux-kernel@vger.kernel.org>
Sent: Saturday, July 05, 2003 1:15 PM
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble


> > Justin, I just tried to enable the nmi watch dog. It doesn't seem to
work on
> > my system I tried both
> >
> > append="nmi_watchdog=1"
> > and
> > append="nmi_watchdog=2"
>
> Is the watchdog enabled in your kernel?  The command line only works
> if you have compiled in support for the watchdog.
>
> --
> Justin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

