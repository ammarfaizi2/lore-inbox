Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUASOGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 09:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbUASOGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 09:06:46 -0500
Received: from ns.suse.de ([195.135.220.2]:55224 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265102AbUASOGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 09:06:45 -0500
Date: Mon, 19 Jan 2004 15:04:39 +0100
From: Olaf Hering <olh@suse.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Greg KH <greg@kroah.com>,
       jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20040119140439.GC31400@suse.de>
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru> <200308311453.00122.arvidjaar@mail.ru> <20030924211823.GA11234@kroah.com> <200401172334.13561.arvidjaar@mail.ru> <20040119130817.GA27953@suse.de> <20040119145917.A981@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040119145917.A981@pclin040.win.tue.nl>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jan 19, Andries Brouwer wrote:

> On Mon, Jan 19, 2004 at 02:08:17PM +0100, Olaf Hering wrote:
> 
> > ... Working with the 'physical
> > location' of removeable devices will probably fail. The usb-storage
> > devices here have a serial field, I really hope it is unique, use it.
> 
> Too optimistic.
> I have several devices with serial number 0.

Nice... Is 'serial' empty, or does it just have '0' in it? And would it
also fail to use vendor/device id for these beasts?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
