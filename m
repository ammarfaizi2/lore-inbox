Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUAIOOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUAIOOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:14:18 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:11136 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261606AbUAIOOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:14:17 -0500
Subject: Re: New FBDev patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Theofilu <noreply@TheosSoft.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040109112733.EB14228003@chello062178157104.9.14.vie.surfer.at>
References: <1bRBM-5lD-13@gated-at.bofh.it> <1bSRe-19C-21@gated-at.bofh.it>
	 <20040109112733.EB14228003@chello062178157104.9.14.vie.surfer.at>
Content-Type: text/plain
Message-Id: <1073657453.795.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 01:10:53 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-09 at 22:27, Andreas Theofilu wrote:
> James Simmons wrote:
> 
> > 
> > 
> > Try it again. I missed a patch for the radeon.
> > 
> This is what happens here:

Looks like James cloned my tree right at the wrong time :)

This is fixed in the current one. In the meantime, change
"rom" with "rom_base"

Ben.


