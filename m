Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270311AbRHWU1l>; Thu, 23 Aug 2001 16:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270279AbRHWU1b>; Thu, 23 Aug 2001 16:27:31 -0400
Received: from mail.fbab.net ([212.75.83.8]:23816 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S270271AbRHWU1V>;
	Thu, 23 Aug 2001 16:27:21 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: alan@lxorguk.ukuu.org.uk raybry@timesn.com twalberg@mindspring.com linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 5.65743 secs)
Message-ID: <043301c12c12$5519c430$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <raybry@timesn.com>, "Tim Walberg" <twalberg@mindspring.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <E15a14h-0004YY-00@the-village.bc.nu>
Subject: Re: macro conflict
Date: Thu, 23 Aug 2001 22:29:39 +0200
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

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> This is one of the big problems with min and max, you get deeply suprising
> and unpleasant results if you don't consider sign propogation, sizes and
> overruns carefully. In C there are some great evils in that area, and its
> one reason a lot of people prefer to write such code explicitly.
>


Yeah, been there, bitten by that. :)

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


