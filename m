Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUIBSsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUIBSsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUIBSsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:48:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:16336 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268036AbUIBSsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:48:09 -0400
Date: Thu, 2 Sep 2004 11:48:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Identify security-related patches
Message-ID: <20040902114807.G1973@build.pdx.osdl.net>
References: <4136C6E1.4090404@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4136C6E1.4090404@bio.ifi.lmu.de>; from fsteiner-mail@bio.ifi.lmu.de on Thu, Sep 02, 2004 at 09:08:17AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Steiner (fsteiner-mail@bio.ifi.lmu.de) wrote:
> is there an easy way to identify all security-related patches out of the
> mass of patches floating around  on linux.bkbits.net or the kernel bugzilla?

No, there's not.  It's not as simple as it seems.  Your best bet is
monitoring vendor updates, as they have the same goal.  Occasionaly
things get applied with a CVE candidate number (CAN-YYYY-NNNN), and
those are security relevant.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
