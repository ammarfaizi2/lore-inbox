Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWHaNfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWHaNfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWHaNfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:35:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10634 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932298AbWHaNfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:35:44 -0400
Date: Thu, 31 Aug 2006 15:35:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       yi.zhu@intel.com, jketreno@linux.intel.com,
       ipw2100-devel@lists.sourceforge.net
Subject: Re: ipw2200: small cleanups
Message-ID: <20060831133529.GG3923@elf.ucw.cz>
References: <20060831123004.GA3923@elf.ucw.cz> <Pine.LNX.4.61.0608311504480.16609@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608311504480.16609@yvahk01.tjqt.qr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-08-31 15:05:45, Jan Engelhardt wrote:
> >
> >Remove dead, commented-out code, and switch to C-style commments.
> 
> Why can't we use C99 comments? We're already depending on so many GCC 
> features that C-C99 is really nitpicky.

They look ugly to my eyes... 
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
