Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUBQWxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266718AbUBQWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:53:19 -0500
Received: from gprs159-87.eurotel.cz ([160.218.159.87]:25732 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266686AbUBQWwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:52:55 -0500
Date: Tue, 17 Feb 2004 23:52:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [PATCH][0/6] A different KGDB stub
Message-ID: <20040217225241.GC666@elf.ucw.cz>
References: <20040217220236.GA16881@smtp.west.cox.net> <20040217143628.0aafd018.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217143628.0aafd018.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The following is my next attempt at a different KGDB stub
> > for your tree
> 
> Is this the patch which everyone agrees on?

It is based on Amit's version, so I think answer is "yes". I certainly
like this one.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
