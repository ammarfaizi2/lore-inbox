Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWGGKyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWGGKyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWGGKyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:54:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56745 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932115AbWGGKyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:54:24 -0400
Date: Fri, 7 Jul 2006 12:54:07 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.16.24
Message-ID: <20060707105407.GA1654@elf.ucw.cz>
References: <20060706222553.GA2946@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706222553.GA2946@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We (the -stable team) are announcing the release of the 2.6.16.24 kernel.
> 
> I'll also be replying to this message with a copy of the patch between
> 2.6.16.23 and 2.6.16.24, as it is small enough to do so.
> 
> The updated 2.6.16.y git tree can be found at:
>  	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> and can be browsed at the normal kernel.org git web browser:
> 	www.kernel.org/git/

Is it still okay to submit patches for 2.6.16-stable? I guess "dirty
buffers flushing broken after resume" may count...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
