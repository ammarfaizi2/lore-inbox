Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130102AbRBIIND>; Fri, 9 Feb 2001 03:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130131AbRBIIMn>; Fri, 9 Feb 2001 03:12:43 -0500
Received: from mail.inup.com ([194.250.46.226]:31750 "EHLO www.inup.com")
	by vger.kernel.org with ESMTP id <S130102AbRBIIMc>;
	Fri, 9 Feb 2001 03:12:32 -0500
Date: Fri, 9 Feb 2001 09:12:27 +0100
From: christophe barbe <christophe.barbe@inup.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: christophe barbe <christophe.barbe@inup.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Message-ID: <20010209091227.A28797@pc8.inup.com>
In-Reply-To: <20010208150859.A19950@pc8.inup.com> <Pine.Linu.4.10.10102090732320.1612-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.Linu.4.10.10102090732320.1612-100000@
 mikeg.weiden.de>; from mikeg@wen-online.de on
  ven, fév 09, 2001 at 08:03:14 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ven, 09 fév 2001 08:03:14 Mike Galbraith wrote:
> I hope that nothing like this is _ever_ integrated (and doubt I need
> be concerned;).  IMHO, hiding output from users arrogantly assumes
> that they are too stupid/ignorant to have any use for such information.

Most user don't want to learn the internal stuff of their OS. They only want to use it and assume (or would like to) that everything is ok. 
You hope graphic boot capability will never be integrated in the kernel but I'm sure you are aware of what is an "OPTION".

Sure it's not a vital need. Distribution makers can already add this on their kernels (and in fact they do that, per example by using aurora). But it could result in a proper implementation. Required modifications are really small.

Moreover there is no need to be ignorant. With LPP, messages are displayed during the boot process and if something goes wrong an little picture inform you. And you can switch to the classic console when you want (by a simple CTRL-ALT-F2).

Christophe

-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
