Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274353AbRITHiZ>; Thu, 20 Sep 2001 03:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274354AbRITHiO>; Thu, 20 Sep 2001 03:38:14 -0400
Received: from mdj.nada.kth.se ([130.237.224.206]:58894 "EHLO mdj.nada.kth.se")
	by vger.kernel.org with ESMTP id <S274353AbRITHiG>;
	Thu, 20 Sep 2001 03:38:06 -0400
From: Mikael Djurfeldt <mdj@mdj.nada.kth.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre12: IO_APIC_init_uniprocessor
Reply-to: Mikael Djurfeldt <djurfeldt@nada.kth.se>
Message-Id: <E15jyPh-0001QM-00@mdj.nada.kth.se>
Date: Thu, 20 Sep 2001 09:38:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the APIC option enabled in my configuration.

When compiling 2.4.10-pre12, the call to IO_APIC_init_uniprocessor in
init/main.c is not resolved.  In fact, searching for this symbol, I
didn't find it anywhere else in the kernel source.

(I didn't have this problem with 2.4.10-pre11.)

Best regards,
Mikael
