Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUABXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbUABXZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:25:57 -0500
Received: from web14902.mail.yahoo.com ([216.136.225.54]:52887 "HELO
	web14902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265692AbUABXZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:25:56 -0500
Message-ID: <20040102232555.38454.qmail@web14902.mail.yahoo.com>
Date: Fri, 2 Jan 2004 15:25:55 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: does udev really require hotplug?
To: Andrea Barisani <lcars@gentoo.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20040102225627.GB24688@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new dri drivers I am working on will require hotplug when they are finished.
They use the hotplug event to reset secondary adapters and get the monitor
EDID/DDC data. The drivers don't require udev but will use it if present.

--- Andrea Barisani <lcars@gentoo.org> wrote:
> On Fri, Jan 02, 2004 at 12:19:05PM -0800, Greg KH wrote:
> > On Fri, Jan 02, 2004 at 11:10:51AM +0100, Andrea Barisani wrote:
> > > 
> > > Hi everybody and happy new year!
> > > 
> > > Just one simple question about a very simple matter that right now 
> > > I can't figure out: does udev need hotplug package presence?


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Find out what made the Top Yahoo! Searches of 2003
http://search.yahoo.com/top2003
