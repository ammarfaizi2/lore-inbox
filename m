Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319669AbSIMPHY>; Fri, 13 Sep 2002 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319673AbSIMPHY>; Fri, 13 Sep 2002 11:07:24 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:31213 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319669AbSIMPHX>; Fri, 13 Sep 2002 11:07:23 -0400
Date: Fri, 13 Sep 2002 09:12:30 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: syam <syam@cisco.com>
cc: Richard Zidlicky <rz@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.19 Oops error
In-Reply-To: <BOEAKBEECIJEDIMOJJJOOEGKCEAA.syam@cisco.com>
Message-ID: <Pine.LNX.4.44.0209130911150.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, syam wrote:
> Will running memtest fix the corruption?

No, but it will detect holes in your memory. Sometimes this bad memory can 
be blacklisted, but badness is known to spread...

If the memory is just too hot, youre well off. Otherwise you might have to 
get some new.


			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

