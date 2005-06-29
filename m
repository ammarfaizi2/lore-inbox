Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVF2DYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVF2DYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 23:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVF2DYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 23:24:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45225 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261375AbVF2DYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 23:24:08 -0400
Date: Wed, 29 Jun 2005 05:24:03 +0200
From: Andi Kleen <ak@suse.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: davej@codemonkey.org.uk, ak@suse.de, linux-kernel@vger.kernel.org,
       sfudally@fau.edu
Subject: Re: [PATCH] amd64-agp: Add SIS760 PCI ID
Message-ID: <20050629032403.GB21575@bragg.suse.de>
References: <42C1E5CA.6060507@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C1E5CA.6060507@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 01:05:30AM +0100, Daniel Drake wrote:
> From: Scott Fudally <sfudally@fau.edu>
> 
> This patch adds the SiS 760 ID to the amd64-agp driver, so that agpgart can be
> used on Athlon64 boards based on this chip.

You mean used automatically. You could always force it before.

> 
> Scott already submitted this but did not recieve any response. To ensure it
> has been sent in correctly, I am resubmitting this now on his behalf.

It's fine for me thanks. I assume Dave will queue it up.

-Andi
