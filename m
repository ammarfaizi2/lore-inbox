Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161298AbWGNUiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbWGNUiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWGNUiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:38:16 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:32439 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161298AbWGNUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:38:16 -0400
Date: Fri, 14 Jul 2006 16:37:44 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Garzik <jeff@garzik.org>,
       jdike@karaya.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] UML build broken everywhere?
Message-ID: <20060714203744.GA6260@ccure.user-mode-linux.org>
References: <44B79AB9.3020401@garzik.org> <44B7A007.2010204@garzik.org> <200607142052.05666.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607142052.05666.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 08:52:05PM +0200, Blaisorblade wrote:
> Jeff (Dike), please choose one of the "simple" patches I suggested (comment 
> out offending code, for instance) since you (correctly) deferred the real fix
> (incorporating klibc's setjmp implementation) to later.

Well, I have a patch which just copies the klibc setjmp stuff into the UML
tree until such time as klibc makes it into mainline.

Any objections?

				Jeff
