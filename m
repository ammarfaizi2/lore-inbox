Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUDLWhR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 18:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbUDLWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 18:37:17 -0400
Received: from linux-bt.org ([217.160.111.169]:55014 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263148AbUDLWhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 18:37:15 -0400
Subject: Re: 2.6.5-mm4 (hci_usb module unloading oops)
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Martin Hermanowski <martin@mh57.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040412220353.GC23692@kroah.com>
References: <20040410200551.31866667.akpm@osdl.org>
	 <20040412101911.GA3823@mh57.de>  <20040412220353.GC23692@kroah.com>
Content-Type: text/plain
Message-Id: <1081809404.8634.24.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Apr 2004 00:36:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > I get an oops when I try to unload the hci_usb module.
> 
> {sigh}  I'm hating that driver right now...
> 
> There are a number of pending bluetooth patches for that driver that fix
> a number of different bugs, so I'm leary of trying to see if this is a
> different one or not at this point in time.  Care to apply all of the
> bluetooth patches and if this still happens, can you report it to the
> linux-usb-devel and bluez-devel mailing lists?

about what pending Bluetooth patches are you talking? There is one from
Alan in 2.6.5-mh3 that should fix this problem and I already sent it
along with my other fixes (not USB related) to Dave.

Regards

Marcel


