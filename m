Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291666AbSBNRBr>; Thu, 14 Feb 2002 12:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291784AbSBNRBg>; Thu, 14 Feb 2002 12:01:36 -0500
Received: from ns.crrstv.net ([209.128.25.4]:33173 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S291666AbSBNRBT>;
	Thu, 14 Feb 2002 12:01:19 -0500
Date: Thu, 14 Feb 2002 13:01:21 -0400 (AST)
From: skidley <skidley@crrstv.net>
X-X-Sender: skidley@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rc1
Message-ID: <Pine.LNX.4.43.0202141254350.8093-100000@localhost.localdomain>
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
I have sucessfully installed the i2c pkg using. Which makes me think
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

