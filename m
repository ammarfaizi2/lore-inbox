Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946642AbWKKQ1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946642AbWKKQ1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946699AbWKKQ1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:27:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43215 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946642AbWKKQ1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:27:52 -0500
Subject: Re: [TRIVIAL PATCH] Added information about Technisat Sky2Pc cards
	- take 3
From: Arjan van de Ven <arjan@infradead.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
In-Reply-To: <4d8e3fd30611110819r7e4dc941od93b9eb1220f2992@mail.gmail.com>
References: <4d8e3fd30611110819r7e4dc941od93b9eb1220f2992@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 11 Nov 2006 17:27:45 +0100
Message-Id: <1163262465.3293.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-11 at 17:19 +0100, Paolo Ciarrocchi wrote:
> Hi all,
> This is the third time I submit the below patch (first sent on the
> 29th of October), I'm adding lkml and Adrian since this is really
> trivial.

hi

>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dvb/cards.txt b/Documentation/dvb/cards.txt
> index ca58e33..cc09187 100644
> --- a/Documentation/dvb/cards.txt
> +++ b/Documentation/dvb/cards.txt
> @@ -22,10 +22,10 @@ o Frontends drivers:
>    - ves1x93           : Alps BSRV2 (ves1893 demodulator) and dbox2 (ves1993)
>    - cx24110           : Conexant HM1221/HM1811 (cx24110 or cx24106
> demod, cx24108 PLL)
>    - grundig_29504-491 : Grundig 29504-491 (Philips TDA8083
> demodulator), tsa5522 PLL
> -   - mt312             : Zarlink mt312 or Mitel vp310 demodulator,

Hi,


your patch has gotten line-wrapped, so it's not possible to apply it
using the patch command ;(

you may need to resend it as an attachment to get it not damaged ;(

Greetings,
   Arjan van de Ven


