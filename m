Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSIZVuP>; Thu, 26 Sep 2002 17:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbSIZVuP>; Thu, 26 Sep 2002 17:50:15 -0400
Received: from ext-ch1gw-1.online-age.net ([216.34.191.35]:9438 "EHLO
	ext-ch1gw-1.online-age.net") by vger.kernel.org with ESMTP
	id <S261531AbSIZVuO>; Thu, 26 Sep 2002 17:50:14 -0400
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC14D8@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Arjan van de Ven'" <arjanv@redhat.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Distributing drivers independent of the kernel source tree
Date: Thu, 26 Sep 2002 17:55:16 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>/lib/modules/`uname -r`/build
>>(yes it's a symlink usually, but that doesn't matter)

> That's true for installing modules, but I'm wondering about getting a
> standalone module compiled. I.e., what is a reliable method 
> for locating the
> include files for the kernel?

Doh!! Sorry Arjan, in haste, I misread your response. I get it now.

Thanks Arjan,
Thanks for pointing that out Tommy.
