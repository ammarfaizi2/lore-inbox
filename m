Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbUL3Qsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUL3Qsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUL3Qsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:48:46 -0500
Received: from mail.x-echo.com ([195.101.94.2]:23342 "EHLO mail.x-echo.com")
	by vger.kernel.org with ESMTP id S261671AbUL3Qsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:48:45 -0500
From: Serge Tchesmeli <zztchesmeli@echo.fr>
Organization: Transiciel
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Subject: Re: 2.6.10 and speedtouch usb
Date: Thu, 30 Dec 2004 17:48:33 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
References: <200412271108.47578.zztchesmeli@echo.fr> <20041229161829.GA9076@panda.itep.ru> <200412301300.30105.duncan.sands@math.u-psud.fr>
In-Reply-To: <200412301300.30105.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412301748.34395.zztchesmeli@echo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Jeudi 30 Décembre 2004 13:00, Duncan Sands a écrit :
> > It looks like the line status monitoring implemented in the driver in
> > 2.6.10 interferes with that in modem_run.  Unless you have a reason to
> > keep using modem_run, you can let it go and use the line status
> > monitoring and firmware loading facilities provided by the driver
> > itself.  Just follow Andrew's advice.
>
> Hi Roman, yes, but it would be good to understand what is going wrong - the
> debug info should help.  It would also be good to know the modem revision.
> Serge, what revision do you see in /proc/bus/usb/devices?
>
> All the best,
>
> Duncan.
> -
I will add debug support, look at modem revision etc.. this weekend and send 
you the informations next week :)
Thanks for all, see you in 2005 for more informations ;)

++

