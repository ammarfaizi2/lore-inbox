Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265586AbRGGBuy>; Fri, 6 Jul 2001 21:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265626AbRGGBuo>; Fri, 6 Jul 2001 21:50:44 -0400
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:20434 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S265586AbRGGBu0>; Fri, 6 Jul 2001 21:50:26 -0400
Message-ID: <3B4677EB.966BA972@home.com>
Date: Fri, 06 Jul 2001 22:46:03 -0400
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Tulip driver doesn't work as module on 2.4.6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With Kernel 2.4.6, when I compile the Tulip driver as a module, I don't
have network connectivity. I can ping myself, and netstat -rn gives the
same table as with earlier kernels, but I can't connect to any of the
other computers on my network. (network = 1 pentium 120, and 1 pentium
133 running a 2.2.16 and a 2.0.36 kernel respectively.) (the module is
loaded correctly and I have all the correct levels of support programs
as listed in the Changes file.) When I compile the Tulip driver directly
into the Kernel, it works.

I would be happy to provide more information to anybody who wants to try
to figure this one out, just ask me what you need to know.

Thanks

John Kacur

jkacur@home.com
