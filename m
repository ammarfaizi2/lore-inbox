Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTIBGra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTIBGra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:47:30 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:59033 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S263575AbTIBGr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:47:29 -0400
From: Richard van der Veen <rysh@home.nl>
To: mzyngier@freesurf.fr
Subject: Re: PROBLEM: tulip driver doesn't work in linux-2.6.0test4 for my Faralon Ethernet card
Date: Tue, 2 Sep 2003 08:47:26 +0200
User-Agent: KMail/1.5.3
References: <200309020429.15747.rysh@home.nl> <wrpllt74xh3.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpllt74xh3.fsf@hina.wild-wind.fr.eu.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309020847.26836.rysh@home.nl>
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 September 2003 06:37, you wrote:
> >>>>> "Richard" == Richard van der Veen <rysh@home.nl> writes:
>
> Richard> lspci (2.6.0test4)
> Richard> ...
> Richard> 00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip
> 21041 Richard> [Tulip Pass 3] (rev 21)
> Richard> ...
>
> Please use the de2104x driver (21040 and 21041 aren't handled by tulip
> anymore).
>
>         M.

Indeed, this works much better :-) 

Thnx

R.

