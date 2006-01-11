Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWAKVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWAKVpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWAKVpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:45:17 -0500
Received: from styx.suse.cz ([82.119.242.94]:4750 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750894AbWAKVpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:45:15 -0500
Date: Wed, 11 Jan 2006 22:45:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dtor_core@ameritech.net, Michael Hanselmann <linux-kernel@hansmi.ch>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060111214532.GA11962@midnight.suse.cz>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <1135575997.14160.4.camel@localhost.localdomain> <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com> <1137015006.5138.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137015006.5138.18.camel@localhost.localdomain>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 08:30:06AM +1100, Benjamin Herrenschmidt wrote:

> > Ok, I am looking at the patch again, and I have a question - do we
> > really need these 3 module parameters? If the goal is to be compatible
> > with older keyboards then shouldn't we stick to one behavior?
> 
> I personally think one parameter is plenty enough (on/off) . Michael,
> can you send Dimitri the latest version of that patch please ?
 
I agree. If you need the compatible behavior.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
