Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130743AbRCMBsr>; Mon, 12 Mar 2001 20:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130742AbRCMBsh>; Mon, 12 Mar 2001 20:48:37 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:45113 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130743AbRCMBse>; Mon, 12 Mar 2001 20:48:34 -0500
Date: Mon, 12 Mar 2001 19:47:23 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - compile fix for 3c509.c in 2.4.3-pre3
In-Reply-To: <15021.30069.381855.886337@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.3.96.1010312194658.4742A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, Neil Brown wrote:
>  in 2.4.3-pre3, drivers/net/3c509.c will not compile ifdef CONFIG_ISAPNP.
> 
>  The following patches fixes the error.  I suspect that 3c515.c has
>  the same problem, but I didn't need to fix that to get my kernel to
>  build... so I didn't.

3c509 and 3c515 fixes already sent to him, twice no less :)


