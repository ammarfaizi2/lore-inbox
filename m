Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272682AbRIYWMI>; Tue, 25 Sep 2001 18:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273355AbRIYWL6>; Tue, 25 Sep 2001 18:11:58 -0400
Received: from 216.234.208.21.zianet.com ([216.234.208.21]:34995 "HELO
	l33tnet0.l33tnet.com") by vger.kernel.org with SMTP
	id <S272682AbRIYWLn>; Tue, 25 Sep 2001 18:11:43 -0400
Message-ID: <026601c1460f$4d152650$3847a9ce@cletus>
From: "Ian Schroeder-Anderson" <ian@l33tnet.com>
To: "Peter Moscatt" <pmoscatt@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010925215741.47198.qmail@web14704.mail.yahoo.com>
Subject: Re: Kernel Recommended Defaults
Date: Tue, 25 Sep 2001 16:13:26 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before configuring the kernel (IE doing make xconfig or make menuconfig, or
just editing .config) do a make oldconfig. That will load the defaults in
all parts, otherwise I'd suggest reading the help that's included with the
given options in the configuration program (IE hit ? in make menuconfig or
click on the *fuzzy memory* help button in make xconfig).

Hope that helps
--Ian


----- Original Message -----
From: "Peter Moscatt" <pmoscatt@yahoo.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Tuesday, September 25, 2001 3:57 PM
Subject: Kernel Recommended Defaults


> I am about to compile and install my first kernel and
> want to make sure I have things pretty well set before
> I create the image.
>
> Is there guides available where they show recommended
> defaults - especially in the Network arena ?
>
> Pete
>
>
> __________________________________________________
> Do You Yahoo!?
> Get email alerts & NEW webcam video instant messaging with Yahoo!
Messenger. http://im.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

