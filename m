Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVI2VNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVI2VNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVI2VNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:13:22 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:24711 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750734AbVI2VNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:13:21 -0400
Message-ID: <433C58D0.3000007@gmail.com>
Date: Thu, 29 Sep 2005 23:12:48 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: janik holy <divizion@pobox.sk>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcmcia bug ?
References: <11ef658a67624a82b2b73decd6a78c07@pobox.sk>
In-Reply-To: <11ef658a67624a82b2b73decd6a78c07@pobox.sk>
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

janik holy napsal(a):

>Hello, i use slack 10.1, kernel 2.6.14-rc2-git7, i have orinoco silver pcmcia wifi card, i compile PCMCIA support into kernel, and orinoco, hermes, orinoco_cs as modules.... after booting loading modules, and run /etc/rc.d/rc.pcmcia i see message >= cardmgr no pcmcia in /proc/devices. after cat /proc/devices there is really no pcmcia. I really dont know what is it, on 2.6.11 with the same kernel conf, its works ok and pcmcia was in /proc/devices. So during i wont have pcmcia in /proc/devices i cant use cardctl and cardmgr ... any idea how to fix it ? where can be a problem ? thanks 
>  
>
Compile yenta, pcmcia, hermes and hermes pcmcia into kernel. I know
about this problem, but I haven't had enough time to solve it.

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10
