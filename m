Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbUCYWIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUCYWIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:08:32 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:12929 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263634AbUCYWI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:08:29 -0500
Date: Thu, 25 Mar 2004 23:08:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
Cc: linux-kernel@vger.kernel.org,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040325220815.GA2179@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz> <200403240748.31837.dtor_core@ameritech.net> <20040324151831.GB25738@atrey.karlin.mff.cuni.cz> <20040324202259.GJ20333@jsambrook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324202259.GJ20333@jsambrook>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  BTW Pavel I'm not arguing that the code has to stay in without
>  modification
>  (e.g. massively stripped down or whatever). But this is one place where
>  kernel code is a lot closer to Joe Enduser's awareness than is usually
>  the case, so IMUO, the priorities shift.

If joe user can survive seeing kernel messages while booting, he
should survive swsusp1-style messages, too....
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
