Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLTVV6>; Wed, 20 Dec 2000 16:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbQLTVVs>; Wed, 20 Dec 2000 16:21:48 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:7227 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130017AbQLTVVk>; Wed, 20 Dec 2000 16:21:40 -0500
Message-ID: <3A411BC2.1E302455@holly-springs.nc.us>
Date: Wed, 20 Dec 2000 15:51:14 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Michael H. Warfield" <mhw@wittsend.com>, linux-kernel@vger.kernel.org
Subject: Re: iptables: "stateful inspection?"
In-Reply-To: <E148q79-0001y2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> It does SYN checking. If you are running 'serious' security you wouldnt be
> allowing outgoing connections anyway. One windows christmascard.exe virus that
> connects back to an irc server to take input and you are hosed.

Thankfully, pine and mutt are, to date, immune to that kind of thing. :)

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
