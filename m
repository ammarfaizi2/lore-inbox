Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262573AbRE3CN6>; Tue, 29 May 2001 22:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRE3CNs>; Tue, 29 May 2001 22:13:48 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:62702 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262589AbRE3CNl>;
	Tue, 29 May 2001 22:13:41 -0400
Date: Tue, 29 May 2001 19:13:38 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
Message-ID: <20010529191338.A14867@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com> <3B14493E.63F861E7@mandrakesoft.com> <20010529182506.A14727@bougret.hpl.hp.com> <3B145127.5B173DFF@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B145127.5B173DFF@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 29, 2001 at 09:47:19PM -0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 09:47:19PM -0400, Jeff Garzik wrote:
> 
> This is ANSI C standard stuff.  If a static object with a scalar type is
> not explicitly initialized, it is initialized to zero by default.
> 
> Sure we can get gcc to recognize that case, but why use gcc to work
> around code that avoids an ANSI feature?

	Apart from this stupid flame that I'm making, I've got my
Intel/Symbol card to work properly with the Orinoco driver. This mean
that we are not far away to have the 4 main flavor of 802.11b working
in 2.4.X (i.e. Lucent/Symbol/PrismII/Aironet).
	See :
http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Orinoco.html#patches

	Just to make sure we end on a positive note ;-) Now, if I
could get the card of Alan to work...

	Have fun, don't take it seriously...

	Jean
