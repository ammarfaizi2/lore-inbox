Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUIIOIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUIIOIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUIIOHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:07:32 -0400
Received: from pfelectron.sophos.com ([213.86.172.148]:38602 "EHLO
	electron.sophos.com") by vger.kernel.org with ESMTP id S264389AbUIIOFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:05:02 -0400
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 09/09/2004 15:04:40,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 09/09/2004 15:04:40,
	Serialize complete at 09/09/2004 15:04:40,
	S/MIME Sign failed at 09/09/2004 15:04:40: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 09/09/2004 15:04:58,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 09/09/2004 15:04:58,
	Serialize complete at 09/09/2004 15:04:58,
	S/MIME Sign failed at 09/09/2004 15:04:58: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 09/09/2004 15:05:01,
	Serialize complete at 09/09/2004 15:05:01
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  patch)
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF7784085E.97108B7F-ON80256F0A.004D3045-80256F0A.004D5C17@green.sophos>
From: tvrtko.ursulin@sophos.com
Date: Thu, 9 Sep 2004 15:04:58 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's not a GPL driver, the kernel part contains a binary object file
>(drivers/amrlibs.o) so I don't see how it can be included in the main
>kernel tree. OTOH, at first glance only the PCI driver needs that
>binary blob, the USB driver doesn't.

Droping in. :)

Kernel part is not required, slmodemd works with the snd-intel8x0m Alsa 
driver. For me at least, and for the PCI version.


-- 
Tvrtko August Ursulin
Software Engineer, Sophos

Tel: 01235 559933
Web: www.sophos.com
Sophos - protecting businesses against viruses and spam

