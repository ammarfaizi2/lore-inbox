Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbTGUPaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 11:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270165AbTGUPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 11:30:24 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:54223 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S269709AbTGUPaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 11:30:20 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: snoopyzwe <snoopyzwe@sina.com>, root@chaos.analogic.com
Subject: Re: how to calculate the system idle time
Date: Mon, 21 Jul 2003 12:45:34 -0300
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <3F1C570E.8080607@sina.com> <Pine.LNX.4.53.0307210935180.17719@chaos> <3F1C613C.6070109@sina.com>
In-Reply-To: <3F1C613C.6070109@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307211245.34244.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"top" is an utility that cames with the Procps package.

Lucas


On Monday 21 July 2003 18:55, snoopyzwe wrote:
> thanks for you advice
> one foolish question
> what "top" means?
> could you tell me more about how to watch the system?
> thank you very much
> I am a newbie
>
> >On Mon, 21 Jul 2003, snoopyzwe wrote:
> >>I want to implement a module, whose main task is to check the system
> >>idle time(no keyboard and mouse input) and suspend the whole system(when
> >>the idle time is long enough). But there comes the problem, how to
> >>calculate the system idle time. How can I get the time user has no
> >>operation.
> >>thanks
> >>snoopyzwe
> >
> >The the source-code of `top` and review it. Make a user-mode
> >daemon to watch the system...
> >
> >
> >Cheers,
> >Dick Johnson
> >Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> >            Note 96.31% of all statistics are fiction.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

