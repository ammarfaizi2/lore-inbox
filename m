Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVLPBQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVLPBQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVLPBQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:16:13 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:20648 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751236AbVLPBQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:16:12 -0500
Date: Fri, 16 Dec 2005 12:15:19 +1100
From: Nathan Scott <nathans@sgi.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216121519.B7544524@wobbly.melbourne.sgi.com>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <20051215231538.GF3419@redhat.com> <20051216004740.GV23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051216004740.GV23349@stusta.de>; from bunk@stusta.de on Fri, Dec 16, 2005 at 01:47:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 01:47:40AM +0100, Adrian Bunk wrote:
> ...
> > [*] Plus a few XFS ones, but that's been a lost cause wrt stack usage
> > for a long time -- people were reporting overflows there before we
> > enabled 4K stacks.
> 
> I remember someone from the XFS maintainers (Nathan?) saying they 
> believe having solved all XFS stack issues.

We don't know of any remaining issues...

> If there are any XFS issues left, do you have a pointer to them?

...so I was curious to see these too, since we've never had any
reported from Dave / anyone else @RH.

cheers.

-- 
Nathan
