Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbRF3DGS>; Fri, 29 Jun 2001 23:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbRF3DGJ>; Fri, 29 Jun 2001 23:06:09 -0400
Received: from zeus.kernel.org ([209.10.41.242]:27839 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264689AbRF3DFz>;
	Fri, 29 Jun 2001 23:05:55 -0400
From: newton@ns.kias.re.kr
Date: Sat, 30 Jun 2001 12:05:44 +0900 (KST)
To: linux-kernel@vger.kernel.org
Subject: [Q] IP autoconfiguration and make xconfig problem.. (fwd)
Message-ID: <Pine.GSO.3.96K.1010630120439.25870A-100000@ns.kias.re.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sorry, I have mistyping...

Hi,

I have a two problem...

1)
kernel 2.4.5 has a IP kernel level autoconfiguration problem.
This kernel do not receive IP from dhcp server.

but, kernel 2.4.3 has not any problem about it.   <--- this...

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


