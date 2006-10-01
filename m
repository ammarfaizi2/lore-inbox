Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWJAR1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWJAR1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWJAR1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:27:54 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:31401 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932084AbWJAR1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:27:52 -0400
Message-Id: <1159723673.14141.272274719@webmail.messagingengine.com>
X-Sasl-Enc: IBjPDfMLmEkJFztQUK9CQPJ8nwSSnmsyzBK29MxS4YFO 1159723673
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Cc: "Miguel Ojeda" <maxextreme@gmail.com>, akpm@osdl.org,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
   <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
   <451FC7DC.7070909@s5r6.in-berlin.de>
   <200610011605.k91G5wJD031632@turing-police.cc.vt.edu>
   <20061001094342.55a331d1.rdunlap@xenotime.net>
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
In-Reply-To: <20061001094342.55a331d1.rdunlap@xenotime.net>
Date: Sun, 01 Oct 2006 19:27:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 09:43:42 -0700, "Randy Dunlap" <rdunlap@xenotime.net>
said:
> On Sun, 01 Oct 2006 12:05:58 -0400 Valdis.Kletnieks@vt.edu wrote:
> > On Sun, 01 Oct 2006 15:51:24 +0200, Stefan Richter said:
> > > I am not sure which looks prettiest. But I know that "LCD display" looks
> > > really bad to everybody who knows what the D stands for. :-)
> > 
> > Maybe I'm confused, but doesn't the D stand for *DIODE*?
>
> not that wikipedia or I know of.

I think there is a problem with the name anyhow. Would you use the 
LCD(d)isplay driver for an OLED screen?

How about auxiliary display or AUXdisplay?

Alexander

> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow

