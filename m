Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSLBSND>; Mon, 2 Dec 2002 13:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSLBSND>; Mon, 2 Dec 2002 13:13:03 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7177 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S262812AbSLBSNC>;
	Mon, 2 Dec 2002 13:13:02 -0500
Date: Mon, 2 Dec 2002 19:20:14 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] generic HDLC update for 2.4.21-pre
Message-ID: <20021202192014.A20163@electric-eye.fr.zoreil.com>
References: <m3el91jiyg.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3el91jiyg.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Mon, Dec 02, 2002 at 02:41:27AM +0100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> Francois: I hope the dscc4 driver from 2.5 is ok. It compiles cleanly
> (not counting the __setup warning if built as a module), but I have no hw
> to test it. I'd be glad if you check it's working correctly. Thanks.

I'd rather avoid pushing the 2.5.x core code for the dscc4 chipset in
2.4 now as some side of it still suck. Is it fine to wait for me to 
update current 2.4.x dscc4 code to new api ? ETA = now + a few days at 
worst.

Btw if someone can get in touch with Infineon, it would be interesting to
know if recent releases of the chipset still behaves as the old ones 
(I only have rather old ones).

Regards

--
Ueimor
