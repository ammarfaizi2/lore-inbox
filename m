Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSBUWsw>; Thu, 21 Feb 2002 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbSBUWsm>; Thu, 21 Feb 2002 17:48:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49158 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285352AbSBUWsd>;
	Thu, 21 Feb 2002 17:48:33 -0500
Message-ID: <3C75793B.1BFF7A1A@mandrakesoft.com>
Date: Thu, 21 Feb 2002 17:48:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
CC: netdev@oss.sgi.com
Subject: eepro100 (was Re: Linux 2.4.18-rc3)
In-Reply-To: <Pine.LNX.4.21.0202211925080.28459-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> rc3:
> - Fix some eepro100 ID's which had problems
>   in -ac merge                                  (Jeff Garzik)
> - Add missing netif_carrier_{on,off} to
>   eepro100                                      (Andrew Morton)

> rc1:
> - eepro100 fixes                                (Jeff Garzik)


eepro100 users,

If you can spare some time, please test and compare 2.4.17 and
2.4.18-rc3 kernel versions, for (a) regressions in performance/behavior,
and (b) -fixed- or improved behavior.

Feedback and further testing sought.

Regards,

	Jeff



-- 
Jeff Garzik      | XXX FREE! secure AFSPC AK-47 unclassified CDC
Building 1024    | NATO SAS CDMA fun with filters Bellcore kibo SSL
MandrakeSoft     | high security goat clones infowar 2600 Magazine
