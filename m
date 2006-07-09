Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbWGIVLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbWGIVLX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWGIVLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:11:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14559 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161154AbWGIVLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:11:21 -0400
Subject: Re: 2.6.18-rc1-mm1
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607091924.k69JOuaw004252@turing-police.cc.vt.edu>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <200607091924.k69JOuaw004252@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 14:11:17 -0700
Message-Id: <1152479477.21576.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 15:24 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 09 Jul 2006 02:11:06 PDT, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 
> Congrats to all the maintainers I've hassled the last few -mm's (in particular,
> Alan Cox, Roman Zippel, and John Stultz) - this one came up basically OK..
> 
> 1) The timer issues with booting with 'vga=794' causing slow console output
> and confusing the error correcting seem resolved - the problem section of
> early userspace is back to the 2-3 seconds it used to be, rather than 2-3 mins.

Great to hear! Thanks for all the testing and feedback! I really
appreciate it!

-john

