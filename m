Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLKJWT>; Mon, 11 Dec 2000 04:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbQLKJWK>; Mon, 11 Dec 2000 04:22:10 -0500
Received: from web1.clubnet.net ([206.126.128.3]:26119 "EHLO web1.clubnet.net")
	by vger.kernel.org with ESMTP id <S129345AbQLKJVt>;
	Mon, 11 Dec 2000 04:21:49 -0500
Message-ID: <000c01c0634f$9d1d8e60$328d7ece@snowline.net>
From: "Eddy" <edmc@snowline.net>
To: "David Feuer" <David_Feuer@brown.edu>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <4.3.2.7.2.20001210235516.00b816f0@postoffice.brown.edu>
Subject: Re: APM-Bios Hang at Boot-up 2.2.16 2.2.17 2.2.18pre26
Date: Mon, 11 Dec 2000 00:51:54 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right Thanks. I did not realize I was not in text mode.

I have somehow fixed the problem by doing something to the apm-bios
settings. I disabled a bunch of stuff in the bios and the thing is working
apparently ok now. Don't ask me what cause I really don't know. It's just
working now.

Thanks, anyway.

This message should not now be in html format... I hope.

----- Original Message -----
From: "David Feuer" <David_Feuer@brown.edu>
To: "Eddy" <edmc@snowline.net>
Sent: Sunday, December 10, 2000 8:55 PM
Subject: Re: APM-Bios Hang at Boot-up 2.2.16 2.2.17 2.2.18pre26


> Note for next time: don't post HTML mail messages to linux-kernel.  This
> annoys many people.
>
> --
> This message has been brought to you by the letter alpha and the number
pi.
> Open Source: Think locally; act globally.
> David Feuer
> David_Feuer@brown.edu
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
