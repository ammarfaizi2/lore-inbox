Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271550AbTGQVfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271551AbTGQVfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:35:37 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:15747 "EHLO server")
	by vger.kernel.org with ESMTP id S271550AbTGQVf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:35:29 -0400
Message-ID: <016401c34cad$5b1f58a0$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Fw: about the crash of the 2.4.20
Date: Thu, 17 Jul 2003 14:49:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Arnaud Ligot" <spyroux@freegates.be>
To: "Jim Gifford" <maillist@jg555.com>
Sent: Thursday, July 17, 2003 1:59 PM
Subject: about the crash of the 2.4.20


Le jeu 17/07/2003 à 21:50, Jim Gifford a écrit :
> ----- Original Message ----- 
> From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> To: "Jim Gifford" <maillist@jg555.com>
> Cc: "lkml" <linux-kernel@vger.kernel.org>
> Sent: Thursday, July 17, 2003 11:46 AM
> Subject: Re: 2.4.22-pre6 deadlock
>
>
> >
> > Jim,
> >
> > I just noticed your kernel is tained.
> >
> > For what reason?
> >
> >
>
> The only patches I use are for netfilter options and the updated megaraid
> driver everything else is stock.
>
> Do you think some of the netfilter options could be causing the problems??
I don't know I use a vanilla kernel (without any patch) and my problem
seems to come from the Reiserfs support.


Marcelo,
    I thought you should see this.


