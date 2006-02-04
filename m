Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945937AbWBDJB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945937AbWBDJB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWBDJB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:01:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46472 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1945937AbWBDJBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:01:25 -0500
Date: Sat, 4 Feb 2006 10:01:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204090112.GJ3291@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602030918.07006.nigel@suspend2.net> <20060203114419.GB2972@elf.ucw.cz> <200602041120.59830.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602041120.59830.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 04-02-06 11:20:54, Nigel Cunningham wrote:
> Hi Pavel.
> 
> On Friday 03 February 2006 21:44, Pavel Machek wrote:
> > [Pavel is willing to take patches, as his cooperation with Rafael
> > shows, but is scared by both big patches and series of 10 small
> > patches he does not understand. He likes patches removing code.]
> 
> Assuming you're refering to the patches that started this thread, what don't 
> you understand? I'm more than happy to explain.

For "suspend2: modules support", it is pretty clear that I do not need
or want that complexity. But for "refrigerator improvements", I did
not understand which parts are neccessary because of suspend2
vs. swsusp differences, and if there is simpler way towards the same
goal. (And thanks for a stress hint...)
								Pavel

-- 
Thanks, Sharp!
