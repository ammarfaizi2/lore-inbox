Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317307AbSGIFlq>; Tue, 9 Jul 2002 01:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGIFlq>; Tue, 9 Jul 2002 01:41:46 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:12814 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317307AbSGIFlp>; Tue, 9 Jul 2002 01:41:45 -0400
Subject: freezing afer switching from graphical to console
From: Michael Gruner <stockraser@yahoo.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1026193021.1076.29.camel@highflyer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Jul 2002 07:38:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since 2.4.17 I have got a problem: trying to switch from graphical
screen to console or to stop my X-session my box freezes. The screen
gets black and nothing more happens. Pressing any keys or trying to
switch to another console the box does not do anything. Only o cold
restart brings the box up again.

Hardware is a MSI6126 with a 440bx chipset. The processor is a 400 MHZ
Celeron on a MS6905 ppga 370 to slot 1 cpu converter. In former times
there were 256MB RAM in there but I got a lot of segfaults during
compiling the kernel. So i removed 128MB and now compiling runs fine.
So I don't think it might be a hardware failure?!

Problems had be seen very often with kernel 2.4.18, now with 2.4.19-rc1
not as often as before. That means: it happens maybe 1 or 2 times a
week. The box is shutted down every day.

Are there any hints for solving this problem?

best regards,
 Michael
-- 
Windmuehlenweg 22 07907 Schleiz
mobil: +491628955029
e-Mail: Michael.Gruner@fh-hof.de


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

