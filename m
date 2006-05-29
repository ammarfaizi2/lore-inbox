Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWE2MrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWE2MrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWE2MrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:47:04 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:49546 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1750818AbWE2MrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:47:03 -0400
Message-ID: <447AED3B.4070708@linuxtv.org>
Date: Mon, 29 May 2006 14:46:51 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Christer Weinigel <christer@weinigel.se>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       Jiri Slaby <jirislaby@gmail.com>, Nathan Laredo <laredo@gnu.org>
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>	<1148825088.1170.45.camel@praia>	<d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>	<1148837483.1170.65.camel@praia>  <m3k686hvzi.fsf@zoo.weinigel.se> <1148841654.1170.70.camel@praia>
In-Reply-To: <1148841654.1170.70.camel@praia>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.137.188.36
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with all other
 SAA7146 drivers
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on 28.05.2006 20:40 Mauro Carvalho Chehab said the following:
> I don't have any saa7146 board, but, on bttv, most boards don't have its
> own PCI ID.

As I said in the other mail, dpc7146, mxb and hexium_orion don't have
subvendor/subdevice ids.

> It won't solve, however, the probing
> intersection for dpc7146f, hexium_orion, mxb, and stradis when no
> subvendor ID is specified on the board.

Probing is probably not possible for the devices mentioned above.

> Cheers, 
> Mauro.

CU
Michael.
