Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUEQRU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUEQRU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEQRU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:20:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:7869 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261580AbUEQRU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:20:58 -0400
Date: Mon, 17 May 2004 10:20:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
Message-ID: <20040517102056.H22989@build.pdx.osdl.net>
References: <20040516025514.3fe93f0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org>; from akpm@osdl.org on Sun, May 16, 2004 at 02:55:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> idr-overflow-fixes.patch
>   Fixes for idr code
>   idr-overflow-fixes fix
>   More fixes for idr code
>   Fixes for POSIX timers
>   timers-signals-rlimits-setuid-fix
>   timers-signals-rlimits-fix
>   timers-signals-rlimits-rename-stuff
>   idr-overflow-fixes fix
>   More fixes for idr code

I think the comments are a bit stale w.r.t. this patch.  It doesn't
actually touch the rlimits any longer.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
