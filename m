Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUAKNfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbUAKNfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:35:06 -0500
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:63874 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262730AbUAKNfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:35:02 -0500
Date: Sun, 11 Jan 2004 14:36:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: To whom should I submit Suspend patches?
Message-ID: <20040111133628.GC897@elf.ucw.cz>
References: <1073677687.2067.29.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073677687.2067.29.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Patrick has a new job and it seems to have swallowed him whole. To whom
> should I be submitting patches for Suspend itself? I was wanting to go
> wild submitting patches before my move to Canberra in three weeks time.
> I do have a BK tree I can put them in if it helps.

It depends...

...on what kind of patches. Fixes for current code adding no features
should go to me. If you want to patch swsusp2 into kernel, well, I
believe we are feature-frozen now. I'd probably be okay with you
taking over pmdisk and turning it into swsusp2, but I'd prefer to keep
simple swsusp for 2.6.

Anyway all of this needs to be decided by Andrew.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
