Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbTGCWvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTGCWvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:51:36 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:5248 "EHLO server")
	by vger.kernel.org with ESMTP id S265479AbTGCWug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:50:36 -0400
Message-ID: <14a301c341b7$7ff0bd50$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>,
       linux-kernel@vger.kernel.org
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com> <01b101c340dc$ede386c0$3300a8c0@Slepetys> <016901c34191$14c4a1c0$3300a8c0@Slepetys> <13e101c3419d$f62f9410$3400a8c0@W2RZ8L4S02> <01f101c3419f$e6d30360$3300a8c0@Slepetys> <913060000.1057267206@aslan.btc.adaptec.com>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Thu, 3 Jul 2003 16:04:46 -0700
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

Justin, I just tried to enable the nmi watch dog. It doesn't seem to work on
my system I tried both

append="nmi_watchdog=1"
and
append="nmi_watchdog=2"

----- Original Message ----- 
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>; "Jim Gifford"
<jim@jg555.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, July 03, 2003 2:20 PM
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble


> > I have no clue for what kind of tests I can do to generate the trouble,
or
> > for what logs, or files to look for.
>
> Have you tried running with the NMI watchdog enabled?
>
> --
> Justin
>
>

