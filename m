Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131371AbQJ2AGC>; Sat, 28 Oct 2000 20:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131437AbQJ2AFw>; Sat, 28 Oct 2000 20:05:52 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:57092 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131371AbQJ2AFk>;
	Sat, 28 Oct 2000 20:05:40 -0400
Message-Id: <200010282351.e9SNpjk11986@sleipnir.valparaiso.cl>
To: sweh@spuddy.mew.co.uk (Stephen Harris)
Cc: linux-kernel@vger.kernel.org
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x 
In-Reply-To: Message from sweh@spuddy.mew.co.uk (Stephen Harris) 
   of "Sat, 28 Oct 2000 19:36:00 GMT." <G35ns0.3rD@spuddy.mew.co.uk> 
Date: Sat, 28 Oct 2000 20:51:45 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sweh@spuddy.mew.co.uk (Stephen Harris) said:
> A lot of talk here has been about syslog and DNS blocking, but the
> original message mentioned:
> 
> > If you send SIGSTOP to syslogd on a Red Hat 6.2 system (glibc 2.1.3,
> > kernel 2.2.x), within a few minutes you will find your entire machine
> > grinds to a halt.  For example, nobody can log in.

Great! Yet another way in which root can get the rope to shoot herself in
the foot. Anything _really_ new?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
