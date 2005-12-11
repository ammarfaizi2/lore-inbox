Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVLKX1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVLKX1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVLKX1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:27:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56239 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750912AbVLKX1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:27:03 -0500
Date: Mon, 12 Dec 2005 00:26:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] swsusp: make image size limit tunable
Message-ID: <20051211232639.GB5982@elf.ucw.cz>
References: <200512111234.15553.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512111234.15553.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 11-12-05 12:34:15, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patch makes the suspend image size limit tunable via
> /sys/power/image_size.
> 
> It is necessary for systems on which there is a limited amount of swap
> available for suspend.  It can also be useful for optimizing performance of
> swsusp on systems with 1 GB of RAM or more.
> 
> This patch depends on the swsusp-limit-image-size patch.
> 
> Please apply.


> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel

-- 
Thanks, Sharp!
