Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263053AbTDBQRr>; Wed, 2 Apr 2003 11:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263055AbTDBQRr>; Wed, 2 Apr 2003 11:17:47 -0500
Received: from mail.zmailer.org ([62.240.94.4]:55002 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S263053AbTDBQRq>;
	Wed, 2 Apr 2003 11:17:46 -0500
Date: Wed, 2 Apr 2003 19:29:10 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK->CVS notify?
Message-ID: <20030402162910.GH29167@mea-ext.zmailer.org>
References: <20030402162121.GA17636@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402162121.GA17636@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 08:21:21AM -0800, Larry McVoy wrote:
> Hi,  I was moving machines around and for the last day and a half or so the
> CVS trees weren't getting updated.  They should be up to date as of now.
> 
> Do we need a cvs-updates mailing list which gets notified of updates or
> do you not care?  I'd be interested in knowing how many people are using
> the CVS trees.

If we need(*),  VGER is already running  bk-commit-head  and bk-commit-24
lists.  Adding  bk-cvs-head-nofify  / bk-cvs-24-notify  makes hardly
detectable addition to load.

(*) I don't have opinnion, I just note about existing lists.
    See:  http://vger.kernel.org/vger-lists.html

> One other comment: there was concern that the incremental update would 
> not be as good as a one pass conversion.  So far, the one pass and the
> incremental results are identical, no exceptions.  So 
> -- 
> ---
> Larry McVoy            lm at bitmover.com          http://www.bitmover.com/lm

/Matti Aarnio
