Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWG0CLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWG0CLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 22:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWG0CLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 22:11:32 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:1230 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750950AbWG0CLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 22:11:32 -0400
Date: Wed, 26 Jul 2006 22:10:47 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Paul Jackson <pj@sgi.com>
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org, adobriyan@gmail.com, vlobanov@speakeasy.net,
       jengelh@linux01.gwdg.de, getshorty_@hotmail.com,
       pwil3058@bigpond.net.au, mb@bu3sch.de, penberg@cs.helsinki.fi,
       stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
Message-ID: <20060727021047.GG28284@filer.fsl.cs.sunysb.edu>
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153945705.44c7d069c5e18@portal.student.luth.se> <20060726180622.63be9e55.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726180622.63be9e55.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 06:06:22PM -0700, Paul Jackson wrote:
> Richard wrote:
> > * removed the #undef false/true and #define false/true
> 
> Good - thanks.
> 
> +enum {
> +	false	= 0,
> +	true	= 1
> +};

You probably have said it before, but why do we need this?

Josef "Jeff" Sipek.

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds
