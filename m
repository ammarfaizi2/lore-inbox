Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTKRVOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 16:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTKRVOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 16:14:24 -0500
Received: from gprs150-94.eurotel.cz ([160.218.150.94]:56966 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263795AbTKRVOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 16:14:23 -0500
Date: Tue, 18 Nov 2003 22:00:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: shoxx@web.de, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: problem with suspend to disk on linux2.6-t9
Message-ID: <20031118210044.GA4172@elf.ucw.cz>
References: <200311172327.24418.shoxx@web.de> <200311180718.00059.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311180718.00059.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> One thing that might be nice is if there was a way to trigger a resume from 
> the initramfs.  "Blow away the current process list and load this binary 
> image of what userspace should look like."  That way figuring out where the 
> sucker lives is a problem you could punt on. :)

This is doable, but rather hard. Way too hard for 2.6.X, anyway.
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
