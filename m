Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWDEU0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWDEU0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDEU0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:26:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45549 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751167AbWDEU0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:26:37 -0400
Date: Wed, 5 Apr 2006 15:26:30 -0500
From: Robin Holt <holt@sgi.com>
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Q on audit, audit-syscall
Message-ID: <20060405202630.GA22453@lnx-holt.americas.sgi.com>
References: <296FAFD9-3D3E-421C-A474-1998BCB8F718@mac.com> <200604052004.k35K4u56010157@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604052004.k35K4u56010157@wildsau.enemy.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 10:04:55PM +0200, Herbert Rosmanith wrote:
> >  Feel free to use  any one of those.  The only commonly-available
> > mainline mechanism to  _trace_ and _intercept_ syscalls is ptrace.  
> 
> with the limitation of ptrace, -EPERM -- see above.

I guess I am dense, but what is already tracing this process?

Thanks,
Robin
