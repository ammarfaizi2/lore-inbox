Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbVCERy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVCERy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVCERtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:49:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23562 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261698AbVCERq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:46:58 -0500
Date: Sat, 5 Mar 2005 17:46:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050305174654.J3282@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	chrisw@osdl.org
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com> <20050305095139.A26541@flint.arm.linux.org.uk> <4229EA0A.8010608@pobox.com> <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>; from torvalds@osdl.org on Sat, Mar 05, 2005 at 09:40:59AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 09:40:59AM -0800, Linus Torvalds wrote:
> I love BK, but what BK does well is merging and maintaining trees full of 
> good stuff. What BK sucks at is experimental stuff where you don't know 
> whether something should be eventually used or not.

Wait a minute - why would stuff going into 2.6.x.y be "experimental"
stuff?  Wasn't stability the whole point of this tree?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
