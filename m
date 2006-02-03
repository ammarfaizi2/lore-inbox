Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946008AbWBCWXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946008AbWBCWXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWBCWX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:23:29 -0500
Received: from kanga.kvack.org ([66.96.29.28]:6320 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751503AbWBCWX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:23:28 -0500
Date: Fri, 3 Feb 2006 17:18:58 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] schedule eepro100.c for removal
Message-ID: <20060203221858.GA3670@kvack.org>
References: <20060203213234.GS4408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203213234.GS4408@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where's the hunk to make the eepro100 driver spew messages about being 
obsolete out upon loading?

		-ben

On Fri, Feb 03, 2006 at 10:32:34PM +0100, Adrian Bunk wrote:
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 18 Jan 2006
> 
> --- linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt.old	2006-01-18 08:38:57.000000000 +0100
> +++ linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt	2006-01-18 08:39:59.000000000 +0100
> @@ -164,0 +165,6 @@
> +---------------------------
> +
> +What:   eepro100 network driver
> +When:   April 2006
> +Why:    replaced by the e100 driver
> +Who:    Adrian Bunk <bunk@stusta.de>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
