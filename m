Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTEIBLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 21:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTEIBLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 21:11:13 -0400
Received: from palrel10.hp.com ([156.153.255.245]:35211 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261887AbTEIBLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 21:11:12 -0400
Date: Thu, 8 May 2003 18:23:45 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030509012344.GA29065@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote :
> 
> What's the position of kernel developers towards using the GPL'd Linux
> kernel modules - that is, device drivers, network stack, filesystems
> etc. - with a binary-only, closed source kernel that is written
> independently of Linux?

	This is the position of Donald Becker :
		http://www.scyld.com/expert/modules.html#legal

	I would personally ask you to respect the wishes of Don with
respect to all drivers containing his code, just to respect the vast
contribution he made to the Linux community.
	My position is similar. If the author wants to make a driver
available to non-GPL kernel, he can always dual license it. In fact,
you will find that many external Linux drivers are available under
dual licences (GPL/MPL, GPL/BSD or GPL/proprietary). For example most
drivers from David Hinds (Pcmcia) are GPL/MPL.

	Have fun...

	Jean
