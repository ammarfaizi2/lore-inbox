Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUBVWMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 17:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUBVWMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 17:12:03 -0500
Received: from gprs147-171.eurotel.cz ([160.218.147.171]:13188 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261764AbUBVWMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 17:12:00 -0500
Date: Sun, 22 Feb 2004 23:11:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Santiago Leon <santil@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
Message-ID: <20040222221137.GB24668@elf.ucw.cz>
References: <40329A24.5070209@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40329A24.5070209@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here's a patch that adds the inter-partition Virtual Ethernet driver for 
> newer IBM iSeries and pSeries systems:
> 
> The patch applies against 2.6.3-rc3...
> 
> Jeff, can you formally add this driver to 2.6?... The differences 
> between this driver and the 2.4 driver that you accepted are fairly 
> trivial (i.e. workqueues instead of tasklets)... The architectural 
> additions that I was waiting for have been applied to the mainline tree...
> 
> Comments and suggestions are always welcome...

Could we get

..less asciiart:

/*
 *
 */

 instead of

/**************
 *            *
 **************/

and shorter identifiers so it fits on, say 100 columns?

								Pavel


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
