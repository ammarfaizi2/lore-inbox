Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTGRQTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271859AbTGRQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:18:12 -0400
Received: from hermes.cicese.mx ([158.97.1.34]:16619 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id S271856AbTGRQRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:17:06 -0400
Message-ID: <3F1820FC.AC29045D@cicese.mx>
Date: Fri, 18 Jul 2003 09:31:56 -0700
From: Serguei Miridonov <mirsev@cicese.mx>
Reply-To: mirsev@cicese.mx
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Wireless linux router
References: <200307171924.UAA21477@mauve.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody know about Linux ported to the devices based on Conexant
CX84200-11 network processor (ARM based)? There are routers of the same type
from different manufacturers:
http://www.seattlewireless.net/index.cgi/FW_2d604Comments which have this
processor, Ethernet switch and PCMCIA wireless card. They are powered by some
proprietary OS with HTTP and Telnet interface. The latter is similar to Cisco
CLI. They are quite cheap and it would be very exciting to port Linux to
these routers. See http://www.tailyn.com.tw/doc/product/router/fw8-604.pdf
for more info.

I have CX84200-11 docs but, as far as I understand, we also need boot block
structure for flash ROM to load something there, and do it so that in case if
something goes wrong, it would be still possible to load original ROM image
to keep it working...

I tried to contact Tailyn (one of the manufacturers) but they would not
disclose anything...

Unfortunately, I have no experience at all with embedded controllers and
flash programming, so if someone is porting Linux to such a router, please,
drop a message.

Thank you.


root@mauve.demon.co.uk wrote:

> A while ago there was much discussion about wireless routers with
> linux kernels, and no source.
>
> Are there any readily available ones that do, and that I can edit the
> image, and that have a couple of meg of RAM/ROM free?

--
Serguei Miridonov


