Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVAMRb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVAMRb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVAMRah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:30:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:22456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261269AbVAMR3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:29:55 -0500
Date: Thu, 13 Jan 2005 09:29:51 -0800
From: Chris Wright <chrisw@osdl.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113092951.Z469@build.pdx.osdl.net>
References: <050LZ7812@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <050LZ7812@server5.heliogroup.fr>; from hubert.tonneau@fullpliant.org on Wed, Jan 12, 2005 at 08:49:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hubert Tonneau (hubert.tonneau@fullpliant.org) wrote:
> Basically, you are currently leaving non distribution related users alone in the
> cold and this is really really bad for the confidence we have in Linux,
> so please publish a 2.6.10.1 with the short term solution to fix the hole.
> Of course this does not prevent to publish 2.6.10.2 when you found a better
> solution, or use a different fix in 2.6.11 since they are not based on 2.6.10.1

I agree (it was part of my original mail), and would like to remedy this.
For now, you can pick up fixes from -ac tree.

> Regards,
> Hubert Tonneau
> 
> 
> PS: I believe that it would also be a very good idea, since Linux is now
> expected to be a mature organisation, to automatically publish 2.6.x.y new holes
> only fix patch for each stable kernel that has been released less than a year ago.
> This would enable smoother upgrade of highly important production servers.

Not sure about that (it's quite some work), but at least the _current_
stable release version.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
