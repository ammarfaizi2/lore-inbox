Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTIVMXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbTIVMXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:23:31 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:11412 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263122AbTIVMX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:23:29 -0400
Message-ID: <0c2001c38104$34c2a690$44ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>,
       "John Bradford" <john@grabjohn.com>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030921110125.GB18677@ucw.cz> <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60> <20030921171632.A11359@pclin040.win.tue.nl>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Date: Mon, 22 Sep 2003 21:21:53 +0900
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

Andries Brouwer:
> Norman Diamond:
> > Vojtech Pavlik:
> >
> > > If anyone would send me samples of Japanese keyboards, you can be sure
> > > I'd test them.
> >
> > Thank you!  I was afraid to ask in advance because I thought that you would
> > either refuse or you would ignore the suggestion.  Dr. Brouwer did refuse,
> > about 3 years ago or so.
>
> Did I really?

You did on 2001.2.23:

> > would have a use for a Japanese USB keyboard
>
> It would be too expensive to mail.
> Instead of keyboards I prefer to collect scancodes of keyboards,
> and you provided some good information.
> (I also got photographs from someone, maybe you saw:
> http://www.win.tue.nl/~aeb/linux/kbd/scancodes-3.html )

Returning to this year:

> I think no kernel changes are required to use Japanese keyboards today.
> (But kbd has to be recompiled with NR_KEYS set to 256.)

I'm not convinced yet.  defkeymap.c_shipped is included in the downloadable
.bz2 file and it is inadequate.

