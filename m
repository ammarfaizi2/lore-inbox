Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267149AbUBMSQD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267151AbUBMSQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:16:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:8924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267149AbUBMSQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:16:00 -0500
Date: Fri, 13 Feb 2004 10:15:58 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why are capabilities disabled?
Message-ID: <20040213101558.A14506@build.pdx.osdl.net>
References: <c0ir6i$erh$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <c0ir6i$erh$2@sea.gmane.org>; from skoehler@upb.de on Fri, Feb 13, 2004 at 04:35:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sven Köhler (skoehler@upb.de) wrote:
> > If capabilities aren't still too unmature, wouldn't it be fine to have 
> > an option in "make menuconfig" to enable them?

they've been in the kernel since 2.2 days.

> Is
>    Security Options -> Enable security models -> Default Capabilities
> what i'm searching for?

That will do it.  If you don't enable security models you'll get
capabilities as the default (to be most compatible with 2.4 kernels).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
