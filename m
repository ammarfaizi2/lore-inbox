Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbTCHTxV>; Sat, 8 Mar 2003 14:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbTCHTxU>; Sat, 8 Mar 2003 14:53:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14340 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262178AbTCHTxT>; Sat, 8 Mar 2003 14:53:19 -0500
Date: Sat, 8 Mar 2003 20:03:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Greg KH <greg@kroah.com>, Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030308200352.E1896@flint.arm.linux.org.uk>
Mail-Followup-To: Petr Vandrovec <vandrove@vc.cvut.cz>,
	Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jeff Garzik <jgarzik@pobox.com>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308191237.GA26374@kroah.com> <20030308194714.GA7340@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030308194714.GA7340@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Sat, Mar 08, 2003 at 08:47:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 08:47:14PM +0100, Petr Vandrovec wrote:
> What are you trying to solve?

Let me re-send my original mail to lkml - it seems to have gobbled up
all this mornings email, completely loosing *everything*.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

