Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTEQUiL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTEQUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:38:11 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:17162 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261824AbTEQUiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:38:10 -0400
Date: Sat, 17 May 2003 21:51:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dreamcast framebuffer updates.
Message-ID: <20030517215102.A21395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Simmons <jsimmons@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305172138420.19598-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305172138420.19598-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Sat, May 17, 2003 at 09:39:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 09:39:41PM +0100, James Simmons wrote:
>  #ifdef CONFIG_MTRR
> -  #include <asm/mtrr.h>
> +#include <asm/mtrr.h>
>  #endif

how can CONFIG_MTRR ever be set for sh?

