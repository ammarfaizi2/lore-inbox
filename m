Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUFJCkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUFJCkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 22:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUFJCkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 22:40:17 -0400
Received: from holomorphy.com ([207.189.100.168]:42632 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264512AbUFJCkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 22:40:14 -0400
Date: Wed, 9 Jun 2004 19:40:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, George Anzinger <george@mvista.com>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Message-ID: <20040610024009.GS1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	high-res-timers-discourse@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, George Anzinger <george@mvista.com>
References: <40C7BE29.9010600@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C7BE29.9010600@am.sony.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 06:49:29PM -0700, Geoff Levand wrote:
> Available at 
> http://tree.celinuxforum.org/pubwiki/moin.cgi/CELinux_5fPatchArchive
> For those interested, the set of three patches provide POSIX high-res 
> timer support for linux-2.6.6.  The core and i386 patches are updates of 
> George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge 
> <http://sourceforge.net/projects/high-res-timers/>.  The ppc32 port is 
> not available on SourceForge yet.
> -Geoff

I thought George Anzinger's high resolution timer patches had already
been merged? At the very least there's already a kernel/posix-timers.c


-- wli
