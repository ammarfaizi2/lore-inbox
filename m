Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272890AbTG3NTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272889AbTG3NTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:19:15 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:9177 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S272884AbTG3NTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:19:12 -0400
Date: Wed, 30 Jul 2003 23:20:15 +1000
From: CaT <cat@zip.com.au>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Philip Graham Willoughby <pgw99@doc.ic.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730132015.GN1395@zip.com.au>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk> <20030730063657.GH1395@zip.com.au> <20030730130015.GA2507@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730130015.GA2507@win.tue.nl>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 03:00:15PM +0200, Andries Brouwer wrote:
> On Wed, Jul 30, 2003 at 04:36:57PM +1000, CaT wrote:
> 
> > Would this (now or in the future) by any chance let one use the keyboard
> > leds for stuff without activating their num lock, caps lock and scroll
> > lock functionality? I'd like to use one of them (at least) as a network
> > traffic indicator but so far I get the sideffects of the functionality
> > being on also. Most annoying when typing. :/
> 
> The use of LEDs as random lights instead of as keyboard status indicators
> has been possible since very early times. See the kernel code, or setleds(1).

Yes. That works. Strange. Every util I tried that was to do what I want
failed because it also activated the functionality so I figured they
couldn't -all- be wrong. :) How wrong I was. Thanks for the heads-up.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
