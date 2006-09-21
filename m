Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWIUV2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWIUV2V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWIUV2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:28:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12970 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750931AbWIUV2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:28:20 -0400
Date: Thu, 21 Sep 2006 23:28:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 2/6] swsusp: Rearrange swap-handling code
Message-ID: <20060921212818.GC2245@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <200609202134.38989.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609202134.38989.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-09-20 21:34:38, Rafael J. Wysocki wrote:
> Rearrange the code in kernel/power/swap.c so that the next patch is more
> readable.
> 
> [This patch only moves the existing code.]
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
