Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312458AbSCYQ4L>; Mon, 25 Mar 2002 11:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312459AbSCYQ4B>; Mon, 25 Mar 2002 11:56:01 -0500
Received: from bitmover.com ([192.132.92.2]:719 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312458AbSCYQzq>;
	Mon, 25 Mar 2002 11:55:46 -0500
Date: Mon, 25 Mar 2002 08:55:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        lm@bitmover.com
Subject: Re: linux-2.4 bitkeeper repository not up to date
Message-ID: <20020325085534.K4755@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
	lm@bitmover.com
In-Reply-To: <200203251544.g2PFiaV02011@localhost.localdomain> <22088.1017071834@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 03:57:14PM +0000, David Woodhouse wrote:
> James.Bottomley@HansenPartnership.com said:
> > The repository linux24.bkbits.net is only at 2.4.19-pre3; however, the
> > kernel  test directory is at 2.4.19-pre4.  I seem to remember that
> > when we had this  problem with the 2.5 repository it was a scripting
> > issue.
> 
> Use linux.bkbits.net/linux-2.4 instead. 
> 
> We should probably remove linux24.bkbits.net. Marcelo? Larry?

In general, we don't automatically clean out old repositories here though
I suspect that will have to change as usage levels rise.  We are going to
start insisting that we get a valid email address when you create a project
on bkbits.net so we can send you mail to ask if you care about something
we want to clean up.

If you created stuff on bkbits.net that you no longer use/need, please log
in as your_proj.adm and do a rm_proj on it.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
