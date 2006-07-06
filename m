Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWGFXun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWGFXun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWGFXun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:50:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46055 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751085AbWGFXum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:50:42 -0400
Date: Fri, 7 Jul 2006 01:50:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
Message-ID: <20060706235020.GA4821@elf.ucw.cz>
References: <20060706193157.GC14043@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706193157.GC14043@phoenix>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Apart from codingstyle issues... yes, it looks good. Hooking various
leds into led subsystem is way better than having all the separate
drivers. I guess I'll have to convert ibm_acpi...
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
