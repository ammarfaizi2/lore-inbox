Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTELShr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTELShr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:37:47 -0400
Received: from palrel11.hp.com ([156.153.255.246]:23717 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262473AbTELSgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:36:52 -0400
Date: Mon, 12 May 2003 11:49:36 -0700
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wireless drivers in 2.5.69
Message-ID: <20030512184936.GD24830@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030506041929.GA5564@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506041929.GA5564@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 09:19:29PM -0700, Greg KH wrote:
> Hi,
> 
> You mentioned in your changes to the wireless core for 2.5.68 that you
> had sent updates for the various drivers to the different driver
> maintainers.  As it looks like your changes made it into 2.5.69, but the
> driver updates didn't, do you have a pointer to these updates so that
> those of us with now non-working wireless cards can test them out?
> 
> Specifically, in my case I'm looking for the updates for the orinoco_pci
> driver, as that has stopped working in 2.5.69, but was working just fine
> in 2.5.68.
> 
> thanks,
> 
> greg k-h

	Hi,

	Just tested 2.5.69-bk7 with an Orinoco Pcmcia card
(orinoco_cs), and as far as my tests goes, it works fine (apart that
the Pcmcia stuff is very flaky).
	Maybe you want to send a detailed bug report to David ?

	Thanks...

	Jean
