Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUL0QEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUL0QEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 11:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUL0QEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 11:04:44 -0500
Received: from mail.x-echo.com ([195.101.94.2]:51199 "EHLO mail.x-echo.com")
	by vger.kernel.org with ESMTP id S261914AbUL0QE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 11:04:29 -0500
From: Serge Tchesmeli <zztchesmeli@echo.fr>
Organization: Transiciel
To: Andrew Benton <andy@benton987.fsnet.co.uk>
Subject: Re: 2.6.10 and speedtouch usb
Date: Mon, 27 Dec 2004 17:03:49 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200412271108.47578.zztchesmeli@echo.fr> <200412271433.28454.zztchesmeli@echo.fr> <41D02EBD.80600@benton987.fsnet.co.uk>
In-Reply-To: <41D02EBD.80600@benton987.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412271703.49289.zztchesmeli@echo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Well it looks like modem_run is giving you problems. If you want you could
> do without it and  let the kernel load the firmware itself. To try this you
> will need to  prepare the firmware by splitting it into two parts To do
> that you'll need a copy of the speedtouch-1.3.1 driver
> http://prdownloads.sourceforge.net/speedtouch/speedtouch-1.3.1.tar.gz?downl
>oad untar it and cd into the speedtouch-1.3.1/src folder and then enter
>
.../...

Ok i will try this next week end, because this machine is actually at 180km 
away from me and if i do something wrong with the modem, i will not be able 
to reach it :)
Actually i have reboot it on 2.6.9 and it work well.
So i will tell you more next week.

Thanks for all :)
