Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938026AbWLHLA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938026AbWLHLA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938027AbWLHLA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:00:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4093 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S938026AbWLHLAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:00:55 -0500
Date: Wed, 12 Jul 2006 14:56:50 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Kristian H?gsberg <krh@redhat.com>, Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel@vger.kernel.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
Message-ID: <20060712145650.GA4403@ucw.cz>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com> <20061205160530.GB6043@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205160530.GB6043@harddisk-recovery.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-12-06 17:05:30, Erik Mouw wrote:
> On Tue, Dec 05, 2006 at 10:13:55AM -0500, Kristian H?gsberg wrote:
> > Marcel Holtmann wrote:
> > >can you please use drivers/firewire/ if you want to start clean or
> > >aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
> > >the directory path is not really helpful.
> > 
> > Yes, that's probably a better idea.  Do you see a problem with using fw_* 
> > as a prefix in the code though?  I don't see anybody using that prefix, but 
> > Stefan pointed out to me that it's often used to abbreviate firmware too.
> 
> So what about fiwi_*? If that's too close to wifi_*, try frwr_.

Ugly, but fwire could be acceptable.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
