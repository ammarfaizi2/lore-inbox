Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTE0MBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTE0MBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:01:07 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:18443 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263305AbTE0MBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:01:06 -0400
Subject: [2.5.70] compile error
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ECnKmGzJ3fNGNriiRWSV"
Organization: 
Message-Id: <1054037655.20115.5.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 May 2003 14:14:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ECnKmGzJ3fNGNriiRWSV
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hello.

I attached it below.

-- 
/================================================\
| Ramón Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\================================================/

--=-ECnKmGzJ3fNGNriiRWSV
Content-Disposition: inline; filename=error.log
Content-Type: application/octet-stream; name=error.log
Content-Transfer-Encoding: 8bit

make[1]: `arch/i386/kernel/asm-offsets.s' está actualizado.
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=1
    CHK     include/linux/compile.h
      CC [M]  net/ipv4/ah.o
      In file included from net/ipv4/ah.c:5:
      include/net/ah.h: En la función `ah_hmac_digest':
      include/net/ah.h:26: aviso: implicit declaration of function `crypto_hmac_init'
      include/net/ah.h:27: error: `crypto_hmac_update' undeclared (first use in this function)
      include/net/ah.h:27: error: (Each undeclared identifier is reported only once
      include/net/ah.h:27: error: for each function it appears in.)
      include/net/ah.h:28: aviso: implicit declaration of function `crypto_hmac_final'
      make[2]: *** [net/ipv4/ah.o] Error 1
      make[1]: *** [net/ipv4] Error 2
      make: *** [net] Error 2


--=-ECnKmGzJ3fNGNriiRWSV--

