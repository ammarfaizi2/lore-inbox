Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267244AbUBSRhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267441AbUBSRhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:37:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:63149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267244AbUBSRhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:37:22 -0500
Date: Thu, 19 Feb 2004 09:37:20 -0800
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Diego_Calleja_Garc=EDa?= <diegocg@teleline.es>
Cc: Nur Hussein <obiwan@slackware.org.my>, linux-kernel@vger.kernel.org
Subject: Re: Security update patch to 2.6.3 for mremap()?
Message-ID: <20040219093720.C22989@build.pdx.osdl.net>
References: <1077201466.1636.19.camel@sophia.localdomain> <20040219170051.6b97f6bf.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040219170051.6b97f6bf.diegocg@teleline.es>; from diegocg@teleline.es on Thu, Feb 19, 2004 at 05:00:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Diego Calleja García (diegocg@teleline.es) wrote:
> El Thu, 19 Feb 2004 22:37:46 +0800 Nur Hussein <obiwan@slackware.org.my> escribió:
> > http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mremap.c@1.7?nav=cset@1.1136.94.4
> 
> AFAIK, the 2.4 path should be this one, shouldn't it?
> http://linux.bkbits.net:8080/linux-2.4/patch@1.1323?nav=index.html|ChangeSet@-2d|cset@1.1323

yep.

> > Is this line missing from 2.6.3, or did Andrew Morton's fixes address 
> > the problem already?
> 
> The 2.6 should be this one (comitted 15 days ago):
> http://linux.bkbits.net:8080/linux-2.5/diffs/mm/mremap.c@1.38?nav=index.html|src/|src/mm|hist/mm/mremap.c
> 2.6.3 is safe, it seems

yep.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
