Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbSLXIob>; Tue, 24 Dec 2002 03:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbSLXIoa>; Tue, 24 Dec 2002 03:44:30 -0500
Received: from smtp003.mail.tpe.yahoo.com ([202.1.238.88]:41228 "HELO
	smtp003.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S267068AbSLXIoa>; Tue, 24 Dec 2002 03:44:30 -0500
Message-ID: <002101c2ab29$cc7df1d0$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: "David Brownell" <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>
References: <3E034860.70509@pacbell.net> <3E0752D3.3060000@pacbell.net>
Subject: Re: USB 2.0 is too slow?
Date: Tue, 24 Dec 2002 15:29:20 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you'd be better off with 2.5.52bk8 or 2.4.20pre with
> the ehci24-1220 patch [*].  Fewer problems over all, and with
> that version, fewer severe ones.

   OK, I will try what you say.  :)
 
> I think "message.c" needs a small patch.  The unlink diagnostics
> have a FIXME next to them (there are false alarms), and I'm not
> entirely trusting that "corrupted" diagnostic either.
 
   :), Will you or someone patch the "message.c" in the future? 

> You're describing a situation where /proc/bus/usb/devices shows the
> devices, but they don't make it all the way into /proc/scsi/scsi?
> Sounds familiar, as if someone else reported it too.

  YES, is this bug going to be fixed in next release?
  BTW, merry christmas and happy new year! 8-)
BR,
  Joseph


-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
