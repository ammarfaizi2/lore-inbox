Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136001AbRDVJiA>; Sun, 22 Apr 2001 05:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136002AbRDVJhu>; Sun, 22 Apr 2001 05:37:50 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:58892 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S136001AbRDVJhh>; Sun, 22 Apr 2001 05:37:37 -0400
Message-ID: <3AE2A660.CDD35707@egu.schule.ulm.de>
Date: Sun, 22 Apr 2001 11:37:36 +0200
From: Steffen Moser <moser@egu.schule.ulm.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linker Error With Kernel 2.4.4pre6 and GCC 2.95.3 (Debian)
In-Reply-To: <20010421161851.A24134@brimstone.ucr.edu> <3AE22753.702859E7@eyal.emu.id.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Eyal Lebedinsky wrote:

> I get the same error with Debian stable (2.2-r3)
> 
> # gcc --version
> 2.95.2

The same here (SuSE Linux 7.0, x86 edition):

  steffen@fs01:~ > gcc --version
  2.95.2

I was able to compile and link it successfully after applying Niels'
patch which is available at:

  http://boudicca.tux.org/hypermail/linux-kernel/2001week17/0009.html

Best regards,
Steffen
