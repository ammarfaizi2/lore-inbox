Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263224AbVBCXcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbVBCXcB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVBCXcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:32:00 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21895 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263224AbVBCXbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:31:51 -0500
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <200502040015.22457.rjw@sisk.pl>
References: <200502021428.12134.rjw@sisk.pl>
	 <200502031420.37560.rjw@sisk.pl> <20050203142203.GB1402@elf.ucw.cz>
	 <200502040015.22457.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1107473644.5727.6.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Feb 2005 10:34:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-02-04 at 10:15, Rafael J. Wysocki wrote:
> Instead of trying to blow up the battery I used the patch that forces the CPU
> to 800 MHz and it apparently survives resuming on batteries - at least 3
> times out of 3 attempts (I'll try some times more tomorrow).
> 
> It seems to boot at 1800 MHz, though, every time, according to
> cpufreq_resume().

Sounds like some good work. Is 800 the minimum for your laptop? I'm just
wondering how you know what speed to choose on other systems.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

