Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVGMICT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVGMICT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 04:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVGMICS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 04:02:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261681AbVGMICM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 04:02:12 -0400
Date: Wed, 13 Jul 2005 01:02:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Tomasz Lemiech <szpajder@staszic.waw.pl>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org, len.brown@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.2 acpi_register_gsi() patch causes problems on Asus A7V333 motherboard
Message-ID: <20050713080201.GI19052@shell0.pdx.osdl.net>
References: <Pine.LNX.4.63.0507121940170.11987@boss.staszic.waw.pl> <20050712182007.GX19052@shell0.pdx.osdl.net> <Pine.LNX.4.63.0507122153110.24219@boss.staszic.waw.pl> <20050712201519.GB19052@shell0.pdx.osdl.net> <Pine.LNX.4.63.0507130957490.2949@boss.staszic.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507130957490.2949@boss.staszic.waw.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomasz Lemiech (szpajder@staszic.waw.pl) wrote:
> Yup, it does, thanks much. Now I see that there was an earlier thread 
> concerning the same problem. Sorry for extra noise.

No problem, thanks for verifying.  That patch should be in .3, so I'm
happy to build up success cases with it.

thanks,
-chris
