Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUASN7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUASN7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:59:43 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:49161 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264954AbUASN7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:59:42 -0500
Date: Mon, 19 Jan 2004 14:59:17 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Olaf Hering <olh@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Greg KH <greg@kroah.com>,
       jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20040119145917.A981@pclin040.win.tue.nl>
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru> <200308311453.00122.arvidjaar@mail.ru> <20030924211823.GA11234@kroah.com> <200401172334.13561.arvidjaar@mail.ru> <20040119130817.GA27953@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040119130817.GA27953@suse.de>; from olh@suse.de on Mon, Jan 19, 2004 at 02:08:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 02:08:17PM +0100, Olaf Hering wrote:

> ... Working with the 'physical
> location' of removeable devices will probably fail. The usb-storage
> devices here have a serial field, I really hope it is unique, use it.

Too optimistic.
I have several devices with serial number 0.

