Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271765AbTGRPGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271778AbTGRPFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:05:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:64395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271836AbTGROph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:45:37 -0400
Date: Fri, 18 Jul 2003 07:57:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I have an oops report for a usb problem. Is this the correct
 list to post it to?
Message-Id: <20030718075709.49e1ab34.rddunlap@osdl.org>
In-Reply-To: <3F17F1CC.1000903@superbug.demon.co.uk>
References: <3F17F1CC.1000903@superbug.demon.co.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 14:10:36 +0100 James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

| Hi,
| 
| I have an oops report for a usb problem. Is this the correct list to 
| post it to.
| I want to post the ksymoops decoded opps, together with a copy of the 
| module's source code in which the oops happened, together with the 
| module.o file, thinking that with all that, it should help the developer 
| of that module cure the problem.
| The source file where the oops happens is 
| ./linux-2.4.21/drivers/usb/host/uhci.c
| 
| I cannot see any kernel mailing list dedicated to usb, so that is why I 
| am asking before posting what might be a largish post of linux-kernel.

>From linux/MAINTAINERS file:

USB SUBSYSTEM
P:	Greg Kroah-Hartman
M:	greg@kroah.com
L:	linux-usb-users@lists.sourceforge.net
L:	linux-usb-devel@lists.sourceforge.net
W:	http://www.linux-usb.org
S:	Supported

--
~Randy
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
