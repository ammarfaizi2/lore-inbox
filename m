Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTKXSxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTKXSxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:53:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:2535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263723AbTKXSxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:53:44 -0500
Date: Mon, 24 Nov 2003 10:53:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Jakob Lell <jlell@JakobLell.de>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031124105321.A16684@osdlab.pdx.osdl.net>
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <200311241857.41324.jlell@JakobLell.de> <200311241921.50001.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200311241921.50001.mbuesch@freenet.de>; from mbuesch@freenet.de on Mon, Nov 24, 2003 at 07:21:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch (mbuesch@freenet.de) wrote:
> What about _not_ modifying the mainstream-kernel behaviour,
> but adding an option, to make users unable to create such hard-links,
> to selinux and/or grsec?

It's already in grsec and owl.  SELinux has the ability to control this
behaviour, just requires the right policy.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
