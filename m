Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbTGCW63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbTGCW4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:56:36 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:13440 "EHLO server")
	by vger.kernel.org with ESMTP id S265488AbTGCWz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:55:26 -0400
Message-ID: <14af01c341b8$2b979c50$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Matthias Andree" <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com> <01b101c340dc$ede386c0$3300a8c0@Slepetys> <016901c34191$14c4a1c0$3300a8c0@Slepetys> <20030703224928.GB20143@merlin.emma.line.org>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Thu, 3 Jul 2003 16:09:34 -0700
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

Tried that before. Before I thought it was the kswapd problem (see list).
But a few hours after I thought it was fixed, bamm it did it again.

I have monitored ps via this script, but I never see anything out of the
ordinary. I will try again and send a copy to the other guy who is having
the problem to see what results we get.


----- Original Message ----- 
From: "Matthias Andree" <matthias.andree@gmx.de>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, July 03, 2003 3:49 PM
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble


> On Thu, 03 Jul 2003, Roberto Slepetys Ferreira wrote:
>
> > Meanning that the Load Average is incompatible with the use of the CPUs.
>
> To find the stuck process that pushes your LA up, try: ps ax | grep -w D
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

