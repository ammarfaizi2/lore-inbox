Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136812AbRASCpq>; Thu, 18 Jan 2001 21:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136828AbRASCpg>; Thu, 18 Jan 2001 21:45:36 -0500
Received: from galileo.bork.org ([209.217.122.37]:7688 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id <S136812AbRASCpa>;
	Thu, 18 Jan 2001 21:45:30 -0500
Subject: pppoe in 2.4.0
From: Martin Hicks <mort@bork.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 18 Jan 2001 21:45:26 -0500
Mime-Version: 1.0
Message-Id: <E14JRYM-0000Ns-00@plato.bork.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Does anyone have pppoe working with 2.4.0?

I'm running 2.4.0-ac9 with ppp and pppoe compiled into the kernel (I've
tried with modules too)

The pppd simply refuses to acknowlege the presence of ppp support in the
kernel.
The last release of pppd was in august 2000.  Was this before the ppp
interface in the 
kernel was overhauled?

mh


-- 
Martin Hicks   || mort@bork.org    
Use PGP/GnuPG  || DSS PGP Key: 0x4C7F2BEE  
Beer: So much more than just a breakfast drink.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
