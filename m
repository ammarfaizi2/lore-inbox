Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWADHKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWADHKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWADHKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:10:34 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:33371 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751586AbWADHKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:10:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: usb/input: Split into separate layers (was: Re: [PATCH 1/1] usb/input: Add missing keys to hid-debug.h)
Date: Wed, 4 Jan 2006 02:10:31 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
References: <20060102233730.GA29826@hansmi.ch> <20060103195344.GC6443@corona.home.nbox.cz> <20060103221133.GA13921@hansmi.ch>
In-Reply-To: <20060103221133.GA13921@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601040210.31849.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 17:11, Michael Hanselmann wrote:
> Hello Vojtech
> 
> On Tue, Jan 03, 2006 at 08:53:44PM +0100, Vojtech Pavlik wrote:
> > We should split HID in two parts - transport and decoding. This would
> > help in many places:
> > [...]
> 
> > I don't have the time to do the split myself, but it shouldn't be too
> > hard.
> 
> And for myself, I think I'm not enough into kernel development already.
> Beside of that, USB isn't my very interest but those patches had to be
> done to get the new PowerBook models running smooth. Hopefully there's
> someone else interested in doing the split because it would be a good
> thing.
> 
> > It would not be the perfect solution for Apple keyboards, [...]
> 
> Does that mean the patch doesn't get into the kernel until the split
> happened?
> 

No, it does not mean that.

-- 
Dmitry
