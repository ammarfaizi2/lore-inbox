Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291825AbSBNS1h>; Thu, 14 Feb 2002 13:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291826AbSBNS11>; Thu, 14 Feb 2002 13:27:27 -0500
Received: from ns.crrstv.net ([209.128.25.4]:12187 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S291825AbSBNS1T>;
	Thu, 14 Feb 2002 13:27:19 -0500
Date: Thu, 14 Feb 2002 14:27:20 -0400 (AST)
From: skidley <skidley@crrstv.net>
X-X-Sender: skidley@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc1
Message-ID: <Pine.LNX.4.43.0202141425240.12470-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have compiled 2.4.18-rc1 and when I try to install i2c and lm_sensors
pkg I get this error:

make: *** No rule to make target
`/usr/src/linux/include/linux/modules/dvbdev.ver', needed by
`kernel/i2c-pport.d'.  Stop.

I have used the same .config that I used to build several kerenels which
I have sucessfully installed the i2c pkg with. Which makes me think
that the particular module isnt in 18-rc1 or it has been changed. 
What selection in the .config would correspond to dvbdev.ver? 
-- 
"Of all the things I've lost I miss my mind the most." -- Ozzy Osbourne

Chad Young           
Registered Linux User #195191
@ http://counter.li.org
-----------------------------------------------------------------------
Linux localhost 2.4.18-pre9-ac3 #2 Thu Feb 14 02:10:53 AST 2002 i686 unknown
 12:50pm  up 29 min,  1 user,  load average: 1.59, 1.61, 1.17


