Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbUKXUNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUKXUNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbUKXULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:11:18 -0500
Received: from fed1rmmtai10.cox.net ([68.230.241.49]:57268 "EHLO
	fed1rmmtai10.cox.net") by vger.kernel.org with ESMTP
	id S262823AbUKXUIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:08:51 -0500
Date: Wed, 24 Nov 2004 11:53:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm3
Message-ID: <20041124185349.GI7839@smtp.west.cox.net>
References: <20041121223929.40e038b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 10:39:29PM -0800, Andrew Morton wrote:

> - It's time to shut things down for a 2.6.10 release now.  I'll do another
>   pass through the -mm lineup for things which should go into 2.6.10.  
> 
>   If anyone has patches in -mm which they think should go into 2.6.10 please
>   let me know.  (particularly ppc/ppc64).  The v4l patches certainly look like
>   they need to go in.
[snip]
> +ppc32-have-the-8260-board-hook-happen-a-bit-later.patch
> +ppc32-fix-__iomem-warnings-in-todc-code.patch
> +ppc32-fix-an-irq-issue-with-cpufreq.patch

These three should go out.

-- 
Tom Rini
http://gate.crashing.org/~trini/
