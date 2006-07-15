Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945898AbWGOUS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbWGOUS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 16:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWGOUS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 16:18:58 -0400
Received: from 1wt.eu ([62.212.114.60]:22282 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161024AbWGOUS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 16:18:58 -0400
Date: Sat, 15 Jul 2006 22:18:10 +0200
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.16.26
Message-ID: <20060715201810.GI2037@1wt.eu>
References: <20060715200856.GA15036@kroah.com> <20060715201026.GC15036@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715201026.GC15036@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 01:10:26PM -0700, Greg KH wrote:
> On Sat, Jul 15, 2006 at 01:08:56PM -0700, Greg KH wrote:
> > We (the -stable team) are announcing the release of the 2.6.16.26 kernel.
> 
> <snip>
> 
> > Greg Kroah-Hartman:
> >       Linux 2.6.16.25
> 
> Ick, I mistyped this, too many version changes recently, it really is
> the 2.6.16.26 release, as the Makefile shows.
> 
> And I don't think there's any way to go back and change a git commit
> message.  Or is there?

You would need to git-reset then git-commit, but it's a little bit dirty
and my annoy the users who will have already fetched your tree. That does
not matter much anyway. I believe that people will understand anyway !

> thanks,
> 
> greg k-h

Cheers,
Willy

