Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265907AbRFYU1A>; Mon, 25 Jun 2001 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265912AbRFYU0u>; Mon, 25 Jun 2001 16:26:50 -0400
Received: from oe52.law11.hotmail.com ([64.4.16.41]:43525 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265907AbRFYU0d>;
	Mon, 25 Jun 2001 16:26:33 -0400
X-Originating-IP: [208.181.16.29]
From: "David Grant" <davidgrant79@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Steven Walter" <srwalter@yahoo.com>, "Andy Ward" <andyw@edafio.com>
In-Reply-To: <3BDF3E4668AD0D49A7B0E3003B294282BC96@etmain.edafio.com>
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
Date: Mon, 25 Jun 2001 13:27:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE52GD1XyCTr9rf3yXv00004cfb@hotmail.com>
X-OriginalArrivalTime: 25 Jun 2001 20:26:27.0784 (UTC) FILETIME=[1CA4BC80:01C0FDB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd be interested in testing any fixes for the VIA Southbridge chip.  I have
an ASUS A7V133.  I was having problems with the IDE controller, but I've
switched to the on-board Promise IDE and it works fine.  I couldn't get rid
of the DMA timeout errors with my VIA vt82c686b, even with the latest
patches.  I even completely disabled DMA (through .config options) and I
although I didn't get DMA timeout errors anymore, everything still came to a
halt under heavy disk usage.

Would it be a good idea to form a small mailing list of people with VIA
chipsets (vt82c686b only)?  Then perhaps we could communicate with Vojtech
more easily, and the VIA southbridge problems might end a little quicker.
It seems like there are a bunch of people still having the VIA problems.

David Grant

----- Original Message -----
From: "Andy Ward" <andyw@edafio.com>
To: "Steven Walter" <srwalter@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, June 25, 2001 12:57 PM
Subject: RE: VIA Southbridge bug (Was: Crash on boot (2.4.5))


> I'd love to help out with testing (alas, my kernel coding skills aren't
> up to fixing this kind of problem).  Heck, if it trashes my linux
> install, no biggie... I've got it ghosted to an image elsewhere...
>
> Anyone wanting to work on this just drop me an email.
>
> -- andyw
>

