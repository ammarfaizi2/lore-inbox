Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVCKRjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVCKRjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCKRjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:39:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:13525 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261237AbVCKRiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:38:15 -0500
Date: Fri, 11 Mar 2005 09:38:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050311173808.GZ28536@shell0.pdx.osdl.net>
References: <20050309083923.GA20461@kroah.com> <m3acpa9qta.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3acpa9qta.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Halasa (khc@pm.waw.pl) wrote:
> Another patch for 2.6.11.x: already in main tree, fixes kernel panic
> on receive with WAN cards based on Hitachi SCA/SCA-II: N2, C101,
> PCI200SYN.
> Also a documentation change fixing user-panic can-t-find-required-software
> failure (just the same patch as in mainline) :-)

We are not accepting documentation fixes.  Could you please send just
the panic fix to stable@kernel.org (cc lkml)?  And add Signed-off-by...

thanks,
-chris
