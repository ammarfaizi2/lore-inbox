Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWBJM3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWBJM3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWBJM3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:29:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58802 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751238AbWBJM3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:29:41 -0500
Date: Fri, 10 Feb 2006 13:29:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] swsusp: fix mistake in documentation
Message-ID: <20060210122923.GM3389@elf.ucw.cz>
References: <200602101314.44571.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602101314.44571.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 10-02-06 13:14:44, Rafael J. Wysocki wrote:
> Hi,
> 
> This patch fixes a mistake in the swsusp documentation.
> 
> Please apply.
> 
> Greetings,
> Rafael

BTW, I believe that Andrew hates these Hi, Please apply and greatings
in patches; because he has to manually strip them down. There's some
'---' convention to work around them, but it is probably easier to
just be "rude" with him and only pass changelog in the mail. Not sure
what to do with diffstat. 

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
ACK, if it is worth anything.

I got these in mail today:

18   T 10-02-06 akpm@osdl.org        ( 144) - swsusp-low-level-interface-rev-2-fix.patch removed fro  
19   T 10-02-06 akpm@osdl.org        ( 107) - suspend-to-ram-allow-video-options-to-be-set-at-runtim  
20   T 10-02-06 akpm@osdl.org        (  84) - swsusp-userland-interface-update.patch removed from -m  
21   T 10-02-06 akpm@osdl.org        ( 101) - suspend-update-documentation.patch removed from -mm tr  
22   T 10-02-06 akpm@osdl.org        ( 108) - led-add-sharp-charger-status-led-trigger-tidy.patch re

...I quite like those patches, and I do not see them going to
Linus. Should I just be more patient, or did they go into some
top-secret-tree I do not know about (but not yet to Linus)?

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
