Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272656AbRITB3s>; Wed, 19 Sep 2001 21:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272712AbRITB3h>; Wed, 19 Sep 2001 21:29:37 -0400
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:19840 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S272656AbRITB30>;
	Wed, 19 Sep 2001 21:29:26 -0400
Message-ID: <3BA94610.9020406@stesmi.com>
Date: Thu, 20 Sep 2001 03:27:44 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: tegeran@home.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <20010919154701.A7381@stud.ntnu.no> <20010919165503.A16359@gondor.com> <9oafeu$1o0$1@penguin.transmeta.com> <01091917190600.00628@c779218-a>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Is there an way someone could find out what Windows, possibly with VIA's 
> 4-in-1 drivers, do with this bit? And for that matter, what the test 
> program that tests it regardless of kernel optimizations does in Windows, 
> if it can be ported?

Windows XP standard doesn't touch it. This MSI K7T Turbo BIOS Rev 2.9 
(latest) which has a KT133A sets it to 0x8D as default though. No, not 
89. One unexplained reboot on the machine (it's not mine) though. I'll 
try setting the bit to 0 though and see if it remains stable. I'll wait 
for another unexplained reboot first though.

// Stefan


