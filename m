Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRLQOZF>; Mon, 17 Dec 2001 09:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280029AbRLQOY4>; Mon, 17 Dec 2001 09:24:56 -0500
Received: from web20501.mail.yahoo.com ([216.136.226.136]:14008 "HELO
	web20501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280026AbRLQOYu>; Mon, 17 Dec 2001 09:24:50 -0500
Message-ID: <20011217142449.34700.qmail@web20501.mail.yahoo.com>
Date: Mon, 17 Dec 2001 15:24:49 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Panic output
To: pwaechtler@loewe-komp.de
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

You may also try kmsgdump which will try to catch the
panic,
dump it to an interactive (blue) screen and let you
read all your
messages, and print them or dump them on a floppy
disk.

depending on the nature of the panic, it cannot always
do
something usefull, but generally it works.

http://wtarreau.free.fr/kmsgdump/0.4.3/

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
