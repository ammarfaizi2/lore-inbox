Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVCKVPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVCKVPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVCKVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:15:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:35249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261810AbVCKVLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 16:11:30 -0500
Date: Fri, 11 Mar 2005 13:11:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050311211122.GP5389@shell0.pdx.osdl.net>
References: <20050309083923.GA20461@kroah.com> <m3acpa9qta.fsf@defiant.localdomain> <20050311173808.GZ28536@shell0.pdx.osdl.net> <m3acp9rivo.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3acp9rivo.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Halasa (khc@pm.waw.pl) wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> > * Krzysztof Halasa (khc@pm.waw.pl) wrote:
> >> Another patch for 2.6.11.x: already in main tree, fixes kernel panic
> >> on receive with WAN cards based on Hitachi SCA/SCA-II: N2, C101,
> >> PCI200SYN.
> >> Also a documentation change fixing user-panic can-t-find-required-software
> >> failure (just the same patch as in mainline) :-)
> >
> > We are not accepting documentation fixes.  Could you please send just
> > the panic fix to stable@kernel.org (cc lkml)?  And add Signed-off-by...
> 
> Sure:

Thanks, added to queue.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
