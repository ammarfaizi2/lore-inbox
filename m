Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268382AbRHCKZh>; Fri, 3 Aug 2001 06:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbRHCKZ0>; Fri, 3 Aug 2001 06:25:26 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:41614 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S268382AbRHCKZM>; Fri, 3 Aug 2001 06:25:12 -0400
Message-ID: <3B6A7B1A.AA4C7F38@pp.inet.fi>
Date: Fri, 03 Aug 2001 13:21:14 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew M <matthew.macleod@btinternet.com>
CC: astor@fast.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto fix for 2.4.7
In-Reply-To: <m15SRKI-000CbBC@Wasteland>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew M wrote:
> This patch fixes crypto support in recent kernels, I know it works with
> 2.4.7, but I have had no time to test with other kernel versions > 2.4.3.
> Should do though, so please try and tell. Remember, its not the "official"
> patch, just a test!

International crypto patch is far more broken than that. For more
information see these linux-crypto posts by me:

    http://mail.nl.linux.org/linux-crypto/2001-07/msg00181.html
    http://mail.nl.linux.org/linux-crypto/2001-07/msg00189.html
        
Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
