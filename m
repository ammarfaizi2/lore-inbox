Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbRBGARv>; Tue, 6 Feb 2001 19:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130542AbRBGARY>; Tue, 6 Feb 2001 19:17:24 -0500
Received: from rak.isternet.sk ([195.72.0.6]:38417 "EHLO rak.isternet.sk")
	by vger.kernel.org with ESMTP id <S129677AbRBGARU>;
	Tue, 6 Feb 2001 19:17:20 -0500
Date: Wed, 7 Feb 2001 01:17:15 +0100
From: Juraj Bednar <juraj@bednar.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: smp_num_cpus redefined? (compiling 2.2.18 for non-SMP?)
Message-ID: <20010207011714.A20005@rak.isternet.sk>
Reply-To: Juraj Bednar <juraj@bednar.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


 sorry, too stupid not to look on the web first, but this should really _NOT_ appear
in the kernel source tree. I found that apm=power_off and make mrproper before
build helps. 





         Juraj.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
