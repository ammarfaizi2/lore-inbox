Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWJJQnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWJJQnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWJJQnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:43:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41703 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030196AbWJJQnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:43:04 -0400
Date: Tue, 10 Oct 2006 18:42:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: IPWireless drivers 
Message-ID: <20061010164249.GA31814@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was asked for IPWireless drivers, but Patrik used email address that
does not work. Anyway, here's the pointer, perhaps other people want
to use them, too?

To: Patrik Israelsson <patrik@israelsson.org>
Subject: Re: IPWireless drivers
X-Warning: Reading this can be dangerous to your mental health.

Hi!

> > I've been looking for Linux drivers for the IPWireless PCMCIA 3G modem, 
> > and a quick googling yielded a mail discussion in LKML started by you. 
> > Since I can't seem to find these drivers anywhere, I felt the need to 
> > contact you - sorry for taking up your time ;)
> 
> Do you have url of that discussion?

It would be still useful. Another person from czech republic is there,
and I may be able to get modem from him.

> > You said in the LKML mail that there are drivers available for linux 
> > 2.6.12, but not for 2.6.16. Where did you find the 2.6.12 drivers? I would 
> > be very grateful if you have them lying around somewhere and/or could 
> > point me to where they can be obtained.
> 
> They were obtained from t-mobile czech republic, and not by
> me. t-mobile said they would get newer version. I'll take a look at
> their site.

Got it. Try
http://t-mobile.cz/Web/ClientFunction.DownloadFile.axd?FileID=2f0a8bc5-b60d-406a-8dde-8b002706799a 

it is linked from 

http://t-mobile.cz/Web/Residential/TarifySluzby/Internet-a-e-mail/co-delat-kdyz-nelze-pouzit-wnw-manager.aspx

link is "Ovladac pro ... 4G ... Linux".

Driver is GPL, can you post it to lkml when you get it from their
.rar, etc?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
