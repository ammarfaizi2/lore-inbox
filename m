Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRECTE7>; Thu, 3 May 2001 15:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132853AbRECTEq>; Thu, 3 May 2001 15:04:46 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:2572 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132483AbRECTEA>; Thu, 3 May 2001 15:04:00 -0400
Message-Id: <200105031903.f43J30s97976@aslan.scsiguy.com>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Success, aic7xxx 6.1.13 fixes boot problems in 2.4.3 2.4.4pre8 2.4.4 (was: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda) 
In-Reply-To: Your message of "Thu, 03 May 2001 17:04:27 +0200."
             <20010503170427.A25904@burns.dt.e-technik.uni-dortmund.de> 
Date: Thu, 03 May 2001 13:03:00 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thanks a lot. (Might it be a good idea to ask Linus and Alan to update the
>driver they ship in 2.4.5-pre or 2.4.4-ac, respectively?)

Alan already has integrated 6.1.11 into his kernels.  6.1.13
corects an issue with cdrecord and improves read performance on
U160 cards, so I'll ping Alan about syncing up.  I've sent Linus
patches post 6.1.5 in the past, but I think he's been too
busy with other issues to push them through.  I'll ping him too.

--
Justin
