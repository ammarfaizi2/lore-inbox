Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTJaLVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTJaLVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:21:20 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:11910 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S263214AbTJaLVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:21:19 -0500
Message-ID: <20031031112118.32444.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: mario.Ohnewald@gmx.de
Cc: linux-kernel@vger.kernel.org
Date: Fri, 31 Oct 2003 19:21:18 +0800
Subject: Re: Swap usage
X-Originating-Ip: 62.101.98.215
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello!
Hello Mario! 
or ciao Mario! because your name really sounds Italian ;)

> I am running Kernel 2.4.21 on a unstable Debian box. I have included my IDE
> Chipset driver
> I have just ONE game server on it and do not use that box very much,
> although, it uses its swap space for some reasons.

> load average: 0.00, 0.01, 0.00
> Mem:    249136k total,   153572k used,    95564k free,    23636k buffers
> Swap:   512024k total,   143652k used,   368372k free,    24500k cached

> # hdparm -t /dev/hda
> /dev/hda:
>  Timing buffered disk reads:  150 MB in  3.01 seconds =  49.83 MB/sec

> How can i find out why it is using so much swap, and how can i prevent it
> form doing so? 
> This swap usage makes my box very slow.

I can only suggest you to try on this machine the 2.4.23-pre9,
it should really improve the VM.

Ciao,
               Paolo
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
