Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWATOgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWATOgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWATOgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:36:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15850 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751023AbWATOgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:36:12 -0500
Date: Fri, 20 Jan 2006 15:35:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jody McIntyre <scjody@modernduck.com>
cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] update the i386 defconfig
In-Reply-To: <20060120040326.GF13178@conscoop.ottawa.on.ca>
Message-ID: <Pine.LNX.4.61.0601201535160.22940@yvahk01.tjqt.qr>
References: <20060119201046.GY19398@stusta.de> <20060120040326.GF13178@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> [...]
>>  #
>>  # IEEE 1394 (FireWire) support
>>  #
>> -CONFIG_IEEE1394=y
>
>Boo.  1394 good.  I suggest the above plus:

And I suggest CONFIG_IEEE1394=m.


>CONFIG_IEEE1394_SBP2=y
>CONFIG_IEEE1394_RAWIO=y
>
>

Jan Engelhardt
-- 
