Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbRFFJtl>; Wed, 6 Jun 2001 05:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbRFFJtc>; Wed, 6 Jun 2001 05:49:32 -0400
Received: from chambertin.convergence.de ([212.84.236.2]:40462 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S261473AbRFFJtS>; Wed, 6 Jun 2001 05:49:18 -0400
Message-ID: <3B1DFA26.22962377@convergence.de>
Date: Wed, 06 Jun 2001 11:38:46 +0200
From: Frank Neuber <neuber@convergence.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux support for PDC20268
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
I try to set up IDE-Support for ARM-Integrator with an PDC20268.
This controller is currently not supported in 
linux/drivers/ide/pdc202xx.c
It is possible to define this controller with the same behavior as 
PDC20267 in linux/drivers/ide/pdc202xx.c?
Because the ARM-Integrator is not compatible to i386 is it possible
to get problems with the PDC-BIOS?

Best regards
Frank

PS: The Mailaddress of Frank Tiernan (frankt@promise.com) is not valid.
Would you be so kind to give me his valid e-mail address ...


-- 
Dipl.-Ing. Elektrotechnik     convergence integrated media gmbh / HW
Frank Neuber                        Rosenthalerstr.51 / 10178 Berlin
Email:  neuber@convergence.de           Phone:  +49(0)30-72 62 06 50
WWW:    www.convergence.de              Fax:    +49(0)30-72 62 06 55
