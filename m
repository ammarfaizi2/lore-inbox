Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWCHUmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWCHUmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWCHUmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:42:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20631 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932452AbWCHUmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:42:09 -0500
Date: Wed, 8 Mar 2006 21:41:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Maier <Thomas.Maier@uni-kassel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-announce] Nigel's work and the future of Suspend2.
Message-ID: <20060308204146.GA4543@elf.ucw.cz>
References: <200603071005.56453.nigel@suspend2.net> <1141737241.5386.28.camel@marvin.se.eecs.uni-kassel.de> <20060308122500.GB3274@elf.ucw.cz> <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141839915.5382.49.camel@marvin.se.eecs.uni-kassel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The only useful thing I could imagine is to try to boot a very minimal
> system and try a lot of cycles and see if it hangs there, too.  But even
> then I see only little hope to file a helpful bug report that might lead
> to finding a solution.

Yes, that would be useful. If it works on minimal system (text-only,
as little modules as possible), and breaks on full system, you should
be able to binary-search for module breaking it...

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
