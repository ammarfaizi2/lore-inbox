Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTIRRvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 13:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTIRRvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 13:51:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:21227 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261971AbTIRRvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 13:51:32 -0400
Date: Thu, 18 Sep 2003 10:50:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: netpoll/netconsole minor tweaks
Message-ID: <20030918105056.A16516@osdlab.pdx.osdl.net>
References: <20030917112447.A24623@osdlab.pdx.osdl.net> <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk> <20030918094832.A16499@osdlab.pdx.osdl.net> <1063905237.2978.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1063905237.2978.0.camel@laptop.fenrus.com>; from arjanv@redhat.com on Thu, Sep 18, 2003 at 07:13:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjanv@redhat.com) wrote:
> Less power consumption, and on HT/SMT CPU's it's a "yield" to the other
> half/halves.

I see, thanks.

> >  Is it worth a patch to convert other things over?
> yes

OK, I'll spin one up, thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
