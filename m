Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263428AbRFAJVz>; Fri, 1 Jun 2001 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263431AbRFAJVp>; Fri, 1 Jun 2001 05:21:45 -0400
Received: from mail.inup.com ([194.250.46.226]:32783 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S263428AbRFAJVf>;
	Fri, 1 Jun 2001 05:21:35 -0400
Date: Fri, 1 Jun 2001 11:20:06 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: qlogicfc driver
Message-ID: <20010601112006.A1127@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My previous mail about Qlogic Fiber Channel driver didn't get so many
attention. 

The QLogic support is like a wall. You can't use a normal e-mail. Instead
of that you should use a http form. And the answer you get is anonymous and
IMHO a standart one.

"... Please check our site periodically for driver updates.
QLogic CSG Product Support "

I know that they have a working IP enhanced driver, DOCs are distributed
under NDA and the IP-enhanced firmware also.

What we have in the kernel today is a nearly broken driver with an obscure
firmware. I believe that this situation only tell (lie) people "this card
is supported under linux" and so they buy this hardware. That's what I've
done.

I'm ready to spend time to modify the driver but I'm not fluent in firmware
microcode reading and I've not managed to find documentations.

There's no maintener for it and Chris Loveland is unreachable.
If somebody has a valid email address for Chris Loveland, Please send it to
me.

If somebody can give me a email address for a HUMAN person working for
QLogic (I hate their e-support 

What about removing this driver ?

Christophe


-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

