Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310428AbSCPQbX>; Sat, 16 Mar 2002 11:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310429AbSCPQbQ>; Sat, 16 Mar 2002 11:31:16 -0500
Received: from bitmover.com ([192.132.92.2]:60803 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310428AbSCPQbA>;
	Sat, 16 Mar 2002 11:31:00 -0500
Date: Sat, 16 Mar 2002 08:30:59 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, lm@bitmover.com,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
Message-ID: <20020316083059.A10086@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	James Bottomley <James.Bottomley@SteelEye.com>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C9372BE.4000808@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Mar 16, 2002 at 11:28:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 11:28:46AM -0500, Jeff Garzik wrote:
> >Well, I tried this, but it just gave me a slew of initial rename conflicts.  
> >
> 
> This is normal, you just need to accept the remote changes for all those 
> new/renamed files.  BitKeeper doesn't support doing this automatically 
> for all files, so I had to highlight the expected BitKeeper response in 
> another window, and then click <paste> on my mouse around 300 times... 
> (~300 new files)

Yuck.  So you knew without any doubt what it was that you wanted?  How?
If this is a common case, I can add an option to the resolver, but it
strikes me that there must be some other problem here.  What are those
300 files?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
