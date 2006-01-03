Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWACWLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWACWLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWACWLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:11:35 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:27933 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932513AbWACWLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:11:35 -0500
Date: Tue, 3 Jan 2006 23:11:33 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: usb/input: Split into separate layers (was: Re: [PATCH 1/1] usb/input: Add missing keys to hid-debug.h)
Message-ID: <20060103221133.GA13921@hansmi.ch>
References: <20060102233730.GA29826@hansmi.ch> <200601030142.32623.dtor_core@ameritech.net> <20060103195344.GC6443@corona.home.nbox.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103195344.GC6443@corona.home.nbox.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vojtech

On Tue, Jan 03, 2006 at 08:53:44PM +0100, Vojtech Pavlik wrote:
> We should split HID in two parts - transport and decoding. This would
> help in many places:
> [...]

> I don't have the time to do the split myself, but it shouldn't be too
> hard.

And for myself, I think I'm not enough into kernel development already.
Beside of that, USB isn't my very interest but those patches had to be
done to get the new PowerBook models running smooth. Hopefully there's
someone else interested in doing the split because it would be a good
thing.

> It would not be the perfect solution for Apple keyboards, [...]

Does that mean the patch doesn't get into the kernel until the split
happened?

Thanks,
Michael
