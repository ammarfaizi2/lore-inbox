Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267382AbUGNURI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267382AbUGNURI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUGNURI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:17:08 -0400
Received: from main.gmane.org ([80.91.224.249]:61333 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267382AbUGNURG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:17:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Date: Wed, 14 Jul 2004 20:16:55 +0000 (UTC)
Organization: Complete.Org
Message-ID: <slrncfb55n.dkv.jgoerzen@christoph.complete.org>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de>
X-Complaints-To: usenet@complete.org
User-Agent: slrn/0.9.8.0 (Linux)
Cc: linux-thinkpad@linux-thinkpad.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-06, Volker Braun <volker.braun@physik.hu-berlin.de> wrote:
> ACPI S3 draws too much power on the T40/T41, this has been confirmed by
> various people (so its not just mine). Suspended it lasts about 10h,
> about twice as long as powered up. Supposed to be 1-2 weeks. 

I'm glad I'm not the only one that is suspecting that.  I just tried
switching my T40p from APM to ACPI.  I got suspending to RAM working in
ACPI, but noticed that when I got it back out of my laptop bag later, it
was physically warm to the touch.  It also had consumed more battery
power than it would have when suspended with APM.  And, if I would shine
a bright light on the screen, I could make out text on it.  In other
words, the backlight was off but it was still displaying stuff.

-- John

