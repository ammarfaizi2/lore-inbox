Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWDQUvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWDQUvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWDQUvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:51:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44045 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751258AbWDQUvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:51:14 -0400
Date: Mon, 17 Apr 2006 22:51:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060417205113.GA11582@stusta.de>
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604171454070.17563@d.namei>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 03:20:55PM -0400, James Morris wrote:
>...
> How about enough time to get us to 2.6.18, say, two months?
> 
> 
> Signed-off-by: James Morris <jmorris@namei.org>
> 
> --- linux-2.6.17-rc1.o/Documentation/feature-removal-schedule.txt	2006-04-15 19:57:53.000000000 -0400
> +++ linux-2.6.17-rc1.x/Documentation/feature-removal-schedule.txt	2006-04-17 15:18:15.000000000 -0400
> @@ -246,3 +246,27 @@ Why:	The interface no longer has any cal
>  Who:	Nick Piggin <npiggin@suse.de>
>  
>  ---------------------------
> +
> +What:	LSM (Linux Security Modules) including BSD Secure Levels.
> +When:	June 2006
>...

Why not directly writing the intention?

  When: before 2.6.18

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

