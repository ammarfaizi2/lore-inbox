Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVAZXrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVAZXrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVAZXrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:47:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:8654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262106AbVAZTVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:21:47 -0500
Date: Wed, 26 Jan 2005 11:21:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: porting Linux to a virtual machine
Message-ID: <20050126112145.Y469@build.pdx.osdl.net>
References: <41F7377E.8050106@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <41F7377E.8050106@sbcglobal.net>; from orangemagicbus@sbcglobal.net on Wed, Jan 26, 2005 at 01:23:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert W. Fuller (orangemagicbus@sbcglobal.net) wrote:
> Has anybody ported Linux to a virtual machine?  Does anybody have any 
> pointers aside from the lkml's abbreviated FAQ entry concering porting 
> to a new processor?  What would be the best way of going about this?  Is 
> there a supported architecture that is simpler than the others and/or 
> better to use as a model?  What about the UML (User Mode Linux) 
> architecture?  Are there doc's, FAQ's, etc. concerning this?   Should I 
> just read the mailing list and harvest the source code?  Thank you for 
> any (positive) input.

See Xen, s390, and power5 for starters.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
