Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267185AbUHDBiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUHDBiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUHDBiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:38:03 -0400
Received: from web14927.mail.yahoo.com ([216.136.225.85]:2662 "HELO
	web14927.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267185AbUHDBhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:37:55 -0400
Message-ID: <20040804013745.7323.qmail@web14927.mail.yahoo.com>
Date: Tue, 3 Aug 2004 18:37:45 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Jon Smirl <jonsmirl@yahoo.com>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1091581190.1862.48.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben, can you put together a first pass on a "VGA arbitration driver"?
You probably know more about the quirks necessary on non-x86 platforms
than anyone else. I can help from the desktop x86 side but I've never
worked on high end hardware that allows things like multiple active VGA
devices. I'm sure the Mac machines and ia64 systems will need some
special code too.


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
