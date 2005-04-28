Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVD1IkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVD1IkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVD1IiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:38:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51615 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261893AbVD1If0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:35:26 -0400
Date: Thu, 28 Apr 2005 10:35:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Li Shaohua <shaohua.li@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-ID: <20050428083459.GM1906@elf.ucw.cz>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com> <20050428002254.461fcf32.akpm@osdl.org> <1114673297.26367.3.camel@sli10-desk.sh.intel.com> <20050428004108.3c670bf2.akpm@osdl.org> <1114676961.26367.12.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114676961.26367.12.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But does setting CONFIG_ACPI_SLEEP cause kernel/power/smp.o to be actually
> > compiled and linked?  I don't think so?
> > 
> > Anyway, please send a tested fix.
> Ha, this one should be ok. Only IA32 support SMP suspend now.

Seems okay... Rafael, what is status of x86-64 smp swsusp?
									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
