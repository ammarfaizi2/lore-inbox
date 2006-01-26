Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWAZKav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWAZKav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWAZKav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:30:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19625 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932282AbWAZKau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:30:50 -0500
Date: Thu, 26 Jan 2006 11:22:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP alternatives
Message-ID: <20060126102250.GA2790@elf.ucw.cz>
References: <43D648CC.4090101@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D648CC.4090101@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Can you include the patch in -mm to give it some testing?  Then merge
> maybe for 2.6.17?  Posted last time in december, with nobody complaining
> any more about the most recent version.  The patch is almost unmodified
> since, I've only had to add a small chunk due to the mutex merge.
> Description is below, the patch (against -rc1-git4 snapshot) is
> attached.

Well, I'm not 100% convinced this is really good idea.. It increases
complexity quite a lot.

Oh and please inline patches.

alternatives.c misses header (copyright, GPL).
								Pavel
-- 
Thanks, Sharp!
