Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWAKVab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWAKVab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWAKVab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:30:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:32979 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750788AbWAKVab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:30:31 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dtor_core@ameritech.net
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <1135575997.14160.4.camel@localhost.localdomain>
	 <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 08:30:06 +1100
Message-Id: <1137015006.5138.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, I am looking at the patch again, and I have a question - do we
> really need these 3 module parameters? If the goal is to be compatible
> with older keyboards then shouldn't we stick to one behavior?

I personally think one parameter is plenty enough (on/off) . Michael,
can you send Dimitri the latest version of that patch please ?

Ben.


