Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbTADRCF>; Sat, 4 Jan 2003 12:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTADRCF>; Sat, 4 Jan 2003 12:02:05 -0500
Received: from 205-158-62-146.outblaze.com ([205.158.62.146]:20643 "HELO
	wspf1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266982AbTADRCE>; Sat, 4 Jan 2003 12:02:04 -0500
Message-ID: <20030104171012.19532.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: kasperd@daimi.au.dk
Cc: linux-kernel@vger.kernel.org
Date: Sun, 05 Jan 2003 01:10:12 +0800
Subject: Re: Linux v2.5.54
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kasper Dupont <kasperd@daimi.au.dk>

[...]
> Could the compiler somehow be using headers from the
> wrong location? (Just a wild guess)

I'm sorry. Really.
But I reverted the whole patchset and then applied again:

patching file drivers/char/agp/frontend.c
patch: **** unexpected end of file in patch

I guess I somehow missed it the first time I applied it.

I'm dowloading again the patch...

There was a problem with the patch on kernel.org or is 
_totaly_ my fault ? I guess the latter...

Ciao,
          Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
