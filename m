Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSFZNLX>; Wed, 26 Jun 2002 09:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSFZNLX>; Wed, 26 Jun 2002 09:11:23 -0400
Received: from pop.gmx.de ([213.165.64.20]:61601 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316573AbSFZNLV>;
	Wed, 26 Jun 2002 09:11:21 -0400
Message-ID: <000101c21d12$b643aae0$0200a8c0@MichaelKerrisk>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: Status of capabilities?
Date: Wed, 26 Jun 2002 14:40:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I asked the question below a while back, I got no response.  Is there
really noone who can say anything about the future of capabilities?

Cheers

Michael

------- Forwarded message follows -------
Date sent:       Fri, 10 May 2002 08:28:55 +0200 (MEST)
From:            Michael Kerrisk <m.kerrisk@gmx.net>
Subject:         Status of capabilities?
To:              linux-kernel@vger.kernel.org

Gidday,

What are the current status and future of capabilites?  There seems to be no
up-to-date information on this anywhere.

It seems capabilities have been partly implemented since 2.2.  That is to
say:

1. The kernel checks (effective) capabilities when performing various
operations.

2. System calls are provided to raise and lower capabilties

What's still missing in 2.4, as far as I can see after reading the sources,
is the ability to set capabilities on executable files so that a process
gains those privileges when executing the file.  I recall seeing some
information somewhere saying this wasn't possible / wasn't going to happen
for ext2.  Is it on the drawing board for any file system?

Thanks

Michael


