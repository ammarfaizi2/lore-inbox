Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUBYW2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUBYW0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:26:00 -0500
Received: from waste.org ([209.173.204.2]:29421 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261646AbUBYWRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:17:36 -0500
Date: Wed, 25 Feb 2004 16:17:19 -0600
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: 3/3 kgdb over netpoll
Message-ID: <20040225221719.GF3883@waste.org>
References: <20040222160849.GA9563@elf.ucw.cz> <20040225215240.GE3883@waste.org> <20040225221246.GH1307@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225221246.GH1307@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 11:12:46PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This is kgdb-over-ethernet patch. Depends on netpoll, and is somehow
> > > experimental.
> > 
> > Please pick up the current kgdboe docs from -mm.
> 
> I'll try to get some docs there, unfortunately this uses completely
> different command line format, so it is not matter of simple copy.

Uh, it's based on netpoll but doesn't use the netpoll parser?!

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
