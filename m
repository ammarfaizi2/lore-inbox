Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267751AbRGURJl>; Sat, 21 Jul 2001 13:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267750AbRGURJc>; Sat, 21 Jul 2001 13:09:32 -0400
Received: from L0190P28.dipool.highway.telekom.at ([62.46.87.188]:55936 "EHLO
	mannix") by vger.kernel.org with ESMTP id <S267748AbRGURJV>;
	Sat, 21 Jul 2001 13:09:21 -0400
Date: Sat, 21 Jul 2001 19:05:39 +0200
To: Stefan Becker <stefan@oph.rwth-aachen.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c
Message-ID: <20010721190539.A557@aon.at>
In-Reply-To: <Pine.LNX.4.21.0107211840250.27803-100000@die-macht>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.21.0107211840250.27803-100000@die-macht>
User-Agent: Mutt/1.3.18i
From: Alexander Griesser <tuxx@aon.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 06:51:07PM +0200, you wrote:
> The following patch against 2.4.6-ac5 does
> -    int par;
> -    if (get_option(&str,&par)) prof_shift = par;
> +	int par;
> +	if (get_option(&str,&par))
> +		prof_shift = par;
>  	return 1;

This is already done in 2.4.7.

regards, alexx
-- 
|   .-.   | Alexander Griesser <tuxx@aon.at> -=- ICQ:63180135 |  .''`. |
|   /v\   |  http://www.tuxx-home.at -=- Linux Version 2.4.7  | : :' : |
| /(   )\ |  FAQ zu at.linux:  http://alfie.ist.org/LinuxFAQ  | `. `'  |
|  ^^ ^^  `---------------------------------------------------´   `-   |
