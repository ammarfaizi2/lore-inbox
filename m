Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277093AbRJHTdc>; Mon, 8 Oct 2001 15:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277099AbRJHTdV>; Mon, 8 Oct 2001 15:33:21 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51430 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277093AbRJHTdH>;
	Mon, 8 Oct 2001 15:33:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: linmodems (was Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices)
Date: Mon, 8 Oct 2001 21:34:02 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.3.96.1011007213223.2882B-100000@mandrakesoft.mandrakesoft.com>
In-Reply-To: <Pine.LNX.3.96.1011007213223.2882B-100000@mandrakesoft.mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15qg7t-0uh6BMC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 October 2001 04:37, Jeff Garzik wrote:
> A work called "modem" by a now-deceased scientist at SGI(IIRC).  Alan
> pointed me to the last piece.  'modem' handles up to 14.4k speed, and
> supports some error correcting protocols we all remember from the BBS
> days.

BTW There was someone working on v.34, but the page hasn't been updated in 
the last 18 months.. http://perso.enst.fr/~bellard/linmodem.html

> Just need someone to glue those pieces together... and you have a
> winmodem driver with the proper portions in userspace, and the proper
> portions in kernel space.

This is also important for USB modems. As Intel requests PC vendors to stop 
including serial ports in 2002 and linux-compatible USB modems are quite hard 
to find it will be really difficult to get an external modem for new 
computers. Almost every new USB modem uses either the ST7554 or the Connexant 
HCF chipset, and at least the ST7554 is controllerless. 

bye...
