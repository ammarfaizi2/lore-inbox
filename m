Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268019AbTB1Qji>; Fri, 28 Feb 2003 11:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268016AbTB1Qji>; Fri, 28 Feb 2003 11:39:38 -0500
Received: from kbl-gs575.zeelandnet.nl ([62.238.66.67]:35575 "EHLO
	unix.pa3gcu.ampr.org") by vger.kernel.org with ESMTP
	id <S268014AbTB1Qjg>; Fri, 28 Feb 2003 11:39:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: pa3gcu <pa3gcu@zeelandnet.nl>
Reply-To: pa3gcu@zeelandnet.nl
Organization: ampr.org
To: "Eng Se-Hsieng" <g0202512@nus.edu.sg>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59: Kernel: No module found in object
Date: Fri, 28 Feb 2003 16:49:48 +0000
X-Mailer: KMail [version 1.2]
Cc: <linux-newbie@vger.kernel.org>
References: <720FB032F37C0D45A11085D881B03368A2B351@MBXSRV24.stu.nus.edu.sg>
In-Reply-To: <720FB032F37C0D45A11085D881B03368A2B351@MBXSRV24.stu.nus.edu.sg>
MIME-Version: 1.0
Message-Id: <03022816494803.00903@unix.pa3gcu>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 February 2003 07:44, Eng Se-Hsieng wrote:
> Dear all,
>
> I have to get the Nokia D211 working in the 2.5.59 kernel. I tweaked the
> driver files (which are meant for 2.4.x kernels) and it compiles and
> installs fine but when I insert the PCMCIA device, I get:

I saw at least 4 decent answers to your origanal question on google.com
thats the URL i told you to look in the last time you wrote here about 2.5 
kernels.
Using development kernels is called "Living on the edge", things work in one 
kernel are are quite possably broken on another.

AFAIK no one can help you here on this list, we are NOT developers.
If you really need the nokia stuff and cant do as other seem to have done, 
then go back to kernel 2.4.xx.

> cardmgr[1302]: get dev info on socket 0 failed: Resource temporarily
> unavailable.

AFAIK all module code has changed in 2.5 kernels, so what you are trying to 
do is certainly not going to work even with a lot of tweeking.

>
> I would really appreciate any help on this.

Ok then write a mail to;
linux-kernel@vger.kernel.org
Ask your question there, if one still can do that that is, i have a small 
idea that you have to be subscribed to that list to be able to mail to it.
So you may need to subscribe first, but be warned, that list has a VERY high 
volume and answers you get may NOT suit your taste.

>
> Thank you.
>
> Regards,
> Se-Hsieng
> (linux-newbie)


-- 
Regards Richard
pa3gcu@zeelandnet.nl
http://people.zeelandnet.nl/pa3gcu/

