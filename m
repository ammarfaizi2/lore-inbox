Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264453AbRFORCs>; Fri, 15 Jun 2001 13:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264455AbRFORCj>; Fri, 15 Jun 2001 13:02:39 -0400
Received: from [207.21.185.24] ([207.21.185.24]:11791 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S264453AbRFORC1>; Fri, 15 Jun 2001 13:02:27 -0400
Message-ID: <3B2A3F90.799ACAC4@lnxw.com>
Date: Fri, 15 Jun 2001 10:02:08 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kmalloc
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi there,

AFAIK there was similar discusion almos a year
ago but i can't remember the details.

kmalloc fails to allocate more than 128KB of
memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)

Any ideas?

I am not quite sure if this is the expected behavior.


	Petko
