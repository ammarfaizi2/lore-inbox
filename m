Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTLKXak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTLKXak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:30:40 -0500
Received: from waste.org ([209.173.204.2]:10439 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264410AbTLKXaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:30:39 -0500
Date: Thu, 11 Dec 2003 17:30:31 -0600
From: Matt Mackall <mpm@selenic.com>
To: inaky.perez-gonzalez@intel.com
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Message-ID: <20031211233031.GD23787@waste.org>
References: <0312030051..akdxcwbwbHdYdmdSaFbbcycyc3a~bzd25502@intel.com> <0312030051.paLaLbTdPdUbed6dXcEbXdDajbVdUd6c25502@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0312030051.paLaLbTdPdUbed6dXcEbXdDajbVdUd6c25502@intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
>  include/linux/fuqueue.h |  451 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/plist.h   |  197 ++++++++++++++++++++
>  kernel/fuqueue.c        |  220 +++++++++++++++++++++++
>  3 files changed, 868 insertions(+)
> 
> +++ linux/include/linux/fuqueue.h	Wed Nov 19 16:42:50 2003

I don't suppose you've run this feature name past anyone in marketting
or PR?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
