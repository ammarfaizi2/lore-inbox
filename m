Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUJGUFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUJGUFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUJGUD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:03:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6066 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268029AbUJGUDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:03:25 -0400
Subject: Re: Probable module bug in linux-2.6.5-1.358
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097175903.29576.12.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
	 <1097175903.29576.12.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097175596.31547.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 19:59:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 20:05, Stephen Hemminger wrote:
> --------------
> /*
>  *   Since some in the Linux-kernel development group want to play
>  *   lawyer, and require that a GPL License exist for every kernel
>  *   module,  I provide the following:
>  *
>  *   Everything in this file (only) is released under the so-called
>  *   GNU Public License, incorporated herein by reference.
>  *
>  *   Now, we just link this with any proprietary code and everybody
>  *   but the lawyers are happy.
>  */

What a fascinating object. I hope thats not reflective of OSDL policy 8)

Is fascinating because my first thought was that if they sign the Induce
act it would be a criminal offence to have it in the USA since its
clearly an incitement and my second thought was that the Bernstein case
appears to argue its protected speech. Interesting times 8)

More seriously the goal of MODULE_LICENSE has never been to -enforce-
GPL licensing. It provides help in understanding what symbols are
definitely off limits and it allows people to identify proprietary stuff
loaded into a system to filter bug reports.

The law on derivative works and copyright in general, murkly alas as it
is, does the enforcing, and unfortunately it is becoming apparent that
the free software world is going to have to go out soon and crack down
hard on abusers, especially those simply shipping Linux binaries with no
source or GPL information.

Alan

