Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVAEXVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVAEXVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVAEXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:21:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13989 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262659AbVAEXSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:18:18 -0500
Date: Thu, 6 Jan 2005 10:17:21 +1100
From: Nathan Scott <nathans@sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bryan Fulton <bryan@coverity.com>, linux-kernel@vger.kernel.org,
       jaharkes@cs.cmu.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, acme@conectiva.com.br, davem@redhat.com,
       kas@fi.muni.cz
Subject: Re: [Coverity] Untrusted user data in kernel
Message-ID: <20050106101721.B1093684@wobbly.melbourne.sgi.com>
References: <1103247211.3071.74.camel@localhost.localdomain> <20050105120423.GA13662@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050105120423.GA13662@logos.cnet>; from marcelo.tosatti@cyclades.com on Wed, Jan 05, 2005 at 10:04:23AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 10:04:23AM -0200, Marcelo Tosatti wrote:
> > ////////////////////////////////////////////////////////////////////
> > // 2:  /fs/xfs/linux-2.6/xfs_ioctl.c::xfs_attrmulti_by_handle     //
> > ////////////////////////////////////////////////////////////////////
> 
> XFS people, can you take care of this one please. Not a security threat,
> protected under ADMIN caps.

Fixed in our local tree coupla weeks ago, it'll be in the next update.

cheers.

-- 
Nathan
