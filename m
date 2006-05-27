Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWE0QeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWE0QeU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWE0QeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 12:34:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6417 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S964902AbWE0QeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 12:34:20 -0400
Date: Sat, 27 May 2006 16:33:28 +0000
From: Pavel Machek <pavel@suse.cz>
To: Don Zickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86 clean up nmi panic messages
Message-ID: <20060527163328.GD4242@ucw.cz>
References: <20060511214933.GU16561@redhat.com> <20060518191700.GC5846@ucw.cz> <20060526175902.GB2839@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526175902.GB2839@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Clean up some of the output messages on the nmi error paths to make more
> sense when they are displayed.  This is mainly a cosmetic fix and
> shouldn't impact any normal code path.  
> 
> Signed-off-by:  Don Zickus <dzickus@redhat.com>

ACK.

> Pavel, 
> 
> I hope this patch addresses your concerns.  This will apply on top of my
> other patch.  

Yes, thanks.

-- 
Thanks for all the (sleeping) penguins.
