Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUBEOVa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUBEOVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:21:30 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:14464 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265274AbUBEOV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:21:28 -0500
Date: Thu, 5 Feb 2004 15:21:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: usb mouse/keyboard problems under 2.6.2
Message-ID: <20040205142155.GA606@ucw.cz>
References: <20040204174748.GA27554@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204174748.GA27554@yggdrasil.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 11:47:48AM -0600, Greg Norris wrote:

> I'm seeing frequent issues with my usb mouse under the 2.6.2 kernel, in
> which the pointer will suddenly freeze.  It remains stuck until I tap a
> key on the keyboard, at which point it continues working normally (for
> a little while).  Also, the keyboard occasionally acts like a key is
> stuck down, which ends promptly when I move the mouse.
> 
> The mouse is an ordinary Logitech wheel-mouse and the keyboard is a
> Microsoft Natural, both of which are connected via an Avocent
> SwitchView USB KVM switch.  The combination works flawlessly under
> 2.6.1.
> 
> Please let me know what additional information I should provide. 
> Thanx!

It looks like you didn't enable the USB drivers.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
