Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUBSR5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUBSR4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:56:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:43708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267455AbUBSR4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:56:40 -0500
Date: Thu, 19 Feb 2004 09:56:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: Nur Hussein <obiwan@slackware.org.my>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security update patch to 2.6.3 for mremap()?
Message-ID: <20040219095636.D22989@build.pdx.osdl.net>
References: <1077201466.1636.19.camel@sophia.localdomain> <20040219170051.6b97f6bf.diegocg@teleline.es> <1077212582.223.17.camel@sophia.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1077212582.223.17.camel@sophia.localdomain>; from obiwan@slackware.org.my on Fri, Feb 20, 2004 at 01:43:02AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nur Hussein (obiwan@slackware.org.my) wrote:
> However, I am still intrigued by this fix:
> 
> http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mremap.c@1.7?nav=cset@1.1136.94.4
> 
> It does not seem to be in 2.6.3. I can only assume 2.6.x does not
> require it? The Changeset says it is to prevent a potential exploit by
> the malicious use of mremap().

It's fixed in 2.6 as well.

http://linux.bkbits.net:8080/linux-2.5/diffs/mm/mremap.c@1.35?nav=index.html|src/|src/mm|hist/mm/mremap.c

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
