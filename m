Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUDCXHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUDCXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:07:22 -0500
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:32794 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S262027AbUDCXHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:07:19 -0500
Message-ID: <003b01c419d0$67e59e50$af7aa8c0@VALUED65BAD02C>
From: "Amit" <khandelw@cs.fsu.edu>
To: <karim@opersys.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <1080849830.91ac1e3f85274@system.cs.fsu.edu>	<406C79E4.1060700@opersys.com> <1081012426.5c22c66499b13@system.cs.fsu.edu>	<406F21CB.8070908@opersys.com> <1081026049.f64d5288b5aaa@system.cs.fsu.edu> <406F2851.6050304@opersys.com>
Subject: Re: kernel 2.4.16
Date: Sat, 3 Apr 2004 18:07:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The patches got installed smoothly however, like in linux-2.4.19 this
time the "Kernel Tracing" option didn't come up when I did "make xconfig". I
copied the CONFIG_TRACE=m from my .config of linux-2.4.19. I hope this is
correct.

Thanks for all the help.
- Amit Khandelwal

----- Original Message ----- 
From: "Karim Yaghmour" <karim@opersys.com>
To: <khandelw@cs.fsu.edu>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Saturday, April 03, 2004 4:10 PM
Subject: Re: kernel 2.4.16


>
> khandelw@cs.fsu.edu wrote:
> > The Patches/ directory of LTT is empty. Do I need to download the
patches from
> > somewhere else? The installation of LTT suggests that we need to patch
the
> > kernel.
>
> The patch was posted to ltt-dev:
> http://www.listserv.shafik.org/pipermail/ltt-dev/2004-March/000561.html
>
> Karim
> -- 
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


