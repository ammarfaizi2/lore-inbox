Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWADRKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWADRKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWADRKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:10:30 -0500
Received: from 5301d.unt0.torres.l21.ma.zugschlus.de ([217.151.83.1]:2256 "EHLO
	torres.zugschlus.de") by vger.kernel.org with ESMTP
	id S1751652AbWADRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:10:30 -0500
Date: Wed, 4 Jan 2006 18:10:29 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 EHCI hang on boot
Message-ID: <20060104171029.GK8079@torres.l21.ma.zugschlus.de>
References: <20060104161844.GA28839@torres.l21.ma.zugschlus.de> <20060104162743.GA11794@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104162743.GA11794@home.fluff.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:27:43PM +0000, Ben Dooks wrote:
> I have the same (but only intermittently) on an Intel i875 based
> board by MSI. In about 25% of the cases it manages to boot past
> these lines, and initialise the mouse connected. 

After trying a few more times, I can now confirm that the issue is
indeed intermittent. My mainboard in question is an MSI as well.

> The usb bus has a low-speed Microsoft mouse on it, and a
> USB 1.1 Hub, with a card reader and serial dongle connected.

The only device on my USB is a Logitech Receiver:
Bus 002 Device 002: ID 046d:c504 Logitech, Inc. Cordless Mouse+Keyboard Receiver

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
