Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264542AbRF3BOx>; Fri, 29 Jun 2001 21:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264593AbRF3BOn>; Fri, 29 Jun 2001 21:14:43 -0400
Received: from ns.kias.re.kr ([210.98.29.2]:62351 "EHLO ns.kias.re.kr")
	by vger.kernel.org with ESMTP id <S264542AbRF3BOg>;
	Fri, 29 Jun 2001 21:14:36 -0400
Date: Sat, 30 Jun 2001 10:15:22 +0900 (KST)
From: <newton@ns.kias.re.kr>
To: linux-kernel@vger.kernel.org
Subject: [Q] IP autoconfiguration and make xconfig problem..
Message-ID: <Pine.GSO.3.96K.1010630100846.24127A-100000@ns.kias.re.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a two problem...

1)
kernel 2.4.5 has a IP kernel level autoconfiguration problem.
This kernel do not receive IP from dhcp server.

but, kernel 2.4.5 has not any problem about it.

2) 
make xconfig has stop with following error message
----------------------
........
drivers/net/Config.in: 145: can't handle dep_bool/dep_mbool/dep_tristate
condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.5/scripts'
make: *** [xconfig] Error 2
----------------------

how can solve this problems?

thanks..

                   Ki hyung Ju

------------------------------------------------------------------
I love Jesus Christ who is my savior. He gives me meanning of life.
In Christ, I have become shepherd and bible teacher.
 
e-mail : newton@kias.re.kr
home   : http://newton.skku.ac.kr/~newton (My old home page)
 
------------------------------------------------------------------

