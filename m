Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVLFK3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVLFK3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVLFK3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:29:35 -0500
Received: from user-0c938qu.cable.mindspring.com ([24.145.163.94]:20690 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932547AbVLFK3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:29:35 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Tue, 6 Dec 2005 10:34:20 +0000
User-Agent: KMail/1.9
Cc: Rob Landley <rob@landley.net>, Greg KH <greg@kroah.com>
References: <20051203152339.GK31395@stusta.de> <200512050559.34464.luke-jr@utopios.org> <200512051834.01384.rob@landley.net>
In-Reply-To: <200512051834.01384.rob@landley.net>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512061034.21336.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 00:34, Rob Landley wrote:
> On Sunday 04 December 2005 23:59, Luke-Jr wrote:
> > On Sunday 04 December 2005 23:22, Greg KH wrote:
> > > On Sun, Dec 04, 2005 at 04:46:31AM +0000, Luke-Jr wrote:
> > > > Well, devfs does have some abilities udev doesn't: hotplug/udev
> > > > doesn't detect everything, and can result in rarer or non-PnP devices
> > > > not being automatically available;
> > >
> > > Are you sure about that today?
> >
> > Nope, but I don't see how udev can possibly detect something that doesn't
> > let the OS know it's there-- except, of course, loading the driver for it
> > and seeing if it works.
>
> Stuff shows up in /sys whether or not Linux has a driver loaded for it.

Only if Linux is aware it exists. I'm thinking of those old ISA cards and 
such.
-- 
Luke-Jr
Developer, Utopios
http://utopios.org/
