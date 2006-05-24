Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWEXXbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWEXXbQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWEXXbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:31:16 -0400
Received: from ns.suse.de ([195.135.220.2]:4300 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932342AbWEXXbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:31:15 -0400
Date: Wed, 24 May 2006 16:29:00 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Linux Device Driver Kit available
Message-ID: <20060524232900.GA18408@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you ever felt teased when driver developers of other operating
systems teased you about a lack of a "proper" driver development kit for
Linux?  Have you felt left out of the crowd when looking at the 36 cdrom
package of documentation and example source code that other operating
systems provide for their developers?  Well feel ashamed no longer!

In coordination with the FreedomHEC[1] conference this week in Seattle,
WA, USA, I'm proud to announce the first release of the Linux Device
Driver Kit.

It is a cd image that contains everything that a Linux device driver
author would need in order to create Linux drivers, including a full
copy of the O'Reilly book, "Linux Device Drivers, third edition" and
pre-built copies of all of the in-kernel docbook documentation for easy
browsing.  It even has a copy of the Linux source code that you can
directly build external kernel modules against.

It can be downloaded for free at:
   kernel.org/pub/linux/kernel/people/gregkh/ddk/

and all attendees of FreedomHEC will get a physical copy, for you to
leave around your desk for other developers to envy.


There's a few things that I would like to include in future versions of
this cdrom:
  - searchable index of all documentation.  jsFind looks like will work
    for this, but due to time constraints, did not make this release.
  - prettier web pages.  I acknolodge I'm no designer, anyone who wants
    to fix up my sparse html with proper CSS support and images would be
    greatly appreciated.
  - More documentation.  Possible inclusion is a snapshot of the
    kernelnewbies wiki.  As we have plenty of room, any pointers to
    stuff that should be included is welcome.

And of course, the image is released under the GPL v2 and can be copied
freely.  There's a cdrom label included in the root directory if you
wish to print it out.

thanks,

greg k-h

[1] Information about FreedomHEC can be found at
	http://freedomhec.pbwiki.com/

