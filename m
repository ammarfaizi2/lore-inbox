Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWAWV4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWAWV4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWAWV4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:56:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:45743
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932226AbWAWV4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:56:42 -0500
Date: Mon, 23 Jan 2006 13:56:30 -0800
From: Greg KH <gregkh@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: david-b@pacbell.net, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: EHCI + APIC errors = no usb goodness
Message-ID: <20060123215630.GA27615@suse.de>
References: <20060123210443.GA20944@suse.de> <20060123132554.13411a1d.zaitcev@redhat.com> <20060123214115.GA15338@suse.de> <20060123135018.4d074a73.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123135018.4d074a73.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 01:50:18PM -0800, Pete Zaitcev wrote:
> On Mon, 23 Jan 2006 13:41:15 -0800, Greg KH <gregkh@suse.de> wrote:
> 
> > Hm, it's a brand-new laptop [...]
> > oh, and 2.6.13 seems to work just fine, with ioapic enabled...
> 
> Sorry, I didn't catch that. You wrote "a real old 2.6 kernel worked" and
> I thought you hark back to 2.6.5 or something. Never mind then.

Sorry, I think 2.6.12 is "real old" sometimes, and that is what I was
thinking of :)

> Oh and by the way, the traceback you posted was 32-bit.

Yeah, I'm running in 32bit mode, haven't gotten around to trying 64bit
mode out on this box yet...

thanks,

greg k-h
