Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275939AbTHONaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275940AbTHONaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:30:16 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:48134 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S275939AbTHONaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:30:12 -0400
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <00f101c36331$20514450$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Paul Nasrat" <pauln@truemesh.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <003701c3630f$387a6330$401a71c3@izidor> <20030815103529.GQ13037@shitake.truemesh.com> <00a501c3631c$676237b0$401a71c3@izidor> <20030815113940.GR13037@shitake.truemesh.com>
Subject: Re: 2.6.0test3mm2 - Synaptics touchpad problem
Date: Fri, 15 Aug 2003 15:28:33 +0200
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

>
> You might want to try against 2.6.0-test3, if it works for you
> then it might be worth going through the synaptics patches in mm2 one by
> one :(

So I tested it against 2.6.0-test3 and 2.6.0-test2 and situation is same.
    Milan

>
>
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/broken-out/
>
>
http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test2/v1/Readme.txt
>
> I'll see if I can replicate this with my laptop this evening.
>
> Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

