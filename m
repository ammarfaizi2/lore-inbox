Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWGUPjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWGUPjn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 11:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWGUPjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 11:39:43 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:25767 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750911AbWGUPjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 11:39:42 -0400
Date: Fri, 21 Jul 2006 18:39:39 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Cc: linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
       James@superbug.demon.co.uk, zab@zabbo.net, sailer@ife.ee.ethz.ch,
       perex@suse.cz
Subject: Re: [PATCH] sound/oss: Conversions from kmalloc+memset to k(c|z)alloc.
Message-ID: <20060721153939.GB28584@rhun.ibm.com>
References: <20060720185812.GB7643@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060720185812.GB7643@lumumba.uhasselt.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 08:58:12PM +0200, Panagiotis Issaris wrote:

> From: Panagiotis Issaris <takis@issaris.org>
> 
> Changes in sound/oss:
> - Conversions from kmalloc+memset to k(c|z)alloc
> - Kill useless type casts
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>

trident.c changes are

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Let me know if you want me to push it seperately from the rest of the
patch.

Cheers,
Muli
