Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVEQLZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVEQLZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVEQLYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:24:21 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:45531 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261393AbVEQLM1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:12:27 -0400
Date: Tue, 17 May 2005 13:04:39 +0200 (CEST)
To: yani.ioannou@gmail.com
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <e9iUj0EZ.1116327879.1515720.khali@localhost>
In-Reply-To: <2538186705051703479bd0c29@mail.gmail.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Greg KH" <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yani,

> Again I'd prefer someone test this particular patch before it be
> applied, because I haven't got an adm1026 to test it with :-).

If you could come up with an additional demonstration patch for either
the lm90 driver or the it87 driver, I would happily give it a try. The
adm1026 has very few users AFAIK so it might not be the best choice to
find testers, although I agree that it was a convenient way to
demonstrate how drivers could benefit from the proposed change.

And, once again, thanks *a lot* for looking into this, this is very much
appreciated.

--
Jean Delvare
