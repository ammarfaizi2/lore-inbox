Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTKIQZk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 11:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTKIQZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 11:25:40 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:21655 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262566AbTKIQZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 11:25:39 -0500
Date: Sun, 9 Nov 2003 08:25:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031109162526.GB24312@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Larry McVoy <lm@bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031109152534.GA24312@work.bitmover.com> <Pine.LNX.4.44.0311090737550.12198-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311090737550.12198-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 07:42:09AM -0800, Davide Libenzi wrote:
> On Sun, 9 Nov 2003, Larry McVoy wrote:
> 
> > On Sun, Nov 09, 2003 at 07:16:15AM -0800, H. Peter Anvin wrote:
> > > That doesn't include anyone who uses the mirrored repository on the
> > > main kernel.org machines.  
> > 
> > Last I checked, kernel.org isn't offering pserver access, just ftp.  If you
> > want to take over the CVS access just say the word.
> 
> It is faster for me to use rsync on the CVS root locally, and then use the 
> local repository instead. Rsync is better than CVS when it comes to syncs.
> Cvsps expecially, really wants a local repository when you start playing 
> heavily with -g.

If that's the preferred interface then maybe we should shut down the pserver
completely and let people rsync it from kernel.org.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
