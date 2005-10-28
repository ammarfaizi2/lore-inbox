Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbVJ1VZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbVJ1VZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbVJ1VZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:25:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:36261 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751813AbVJ1VZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:25:39 -0400
Date: Sat, 29 Oct 2005 07:25:34 +1000
From: Nathan Scott <nathans@sgi.com>
To: AndyLiebman@aol.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: What happened to XFS Quota Support?
Message-ID: <20051029072533.A6139033@wobbly.melbourne.sgi.com>
References: <46.74cc8004.3093e511@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <46.74cc8004.3093e511@aol.com>; from AndyLiebman@aol.com on Fri, Oct 28, 2005 at 04:33:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 04:33:21PM -0400, AndyLiebman@aol.com wrote:
> I tried compiling XFS statically into the kernel and it's also a "no go" on  
> quota support. So, am I to conclude that 2.6.14 as it currently stands cannot  
> support XFS quotas?

Hmm, I'd have thought it'd work builtin, thats how I tend to use it.
Either way, the code is all there, its just an annoying config issue.

> As you know, we have quite a few users who have been waiting for the XFS  
> changes that went into 2.6.14 (as you and I have discussed).  Hope the fix  comes 
> along soon. 

Theres a patch already floating around that will resolve it, let me
know how that goes.

cheers.

-- 
Nathan
