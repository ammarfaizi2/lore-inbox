Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTBUJLd>; Fri, 21 Feb 2003 04:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbTBUJLd>; Fri, 21 Feb 2003 04:11:33 -0500
Received: from [213.171.53.133] ([213.171.53.133]:49931 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267267AbTBUJLc>;
	Fri, 21 Feb 2003 04:11:32 -0500
Date: Fri, 21 Feb 2003 12:20:51 +0300
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: toptan@eunet.eu
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
Message-Id: <20030221122051.20942f70.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	GA-7VAXPUltra (KT400)   + ATI Radeon R9000      = passed.
>                                                + GeForce 2MX400        = passed.
>        Chaintech 7AJA2E (KT133)        + ATI Radeon R9000      = passed.
>                                                + GeForce 2MX400        = passed.
>
>        Abit (i810)                             + ATI Radeon R9000      = passed.
>                                                + GeForce 2MX400        = passed.

 From all this hardware only the KT400+R9000 pair possibly engage in AGP8x transfers,
and i`m suspicious whether R9000 does it at all...

 So i think somebody testing it on real AGP3.0-capable hardware would do good...

regards, Samium Gromoff
