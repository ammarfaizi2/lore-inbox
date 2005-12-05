Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVLFCbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVLFCbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVLFCbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:31:39 -0500
Received: from quark.didntduck.org ([69.55.226.66]:22426 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751335AbVLFCbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:31:38 -0500
Message-ID: <43944F42.2070207@didntduck.org>
Date: Mon, 05 Dec 2005 09:31:30 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random>
In-Reply-To: <20051206011844.GO28539@opteron.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Dec 05, 2005 at 04:18:51AM -0800, William Lee Irwin III wrote:
>> The December 6 event is extraordinarily unlikely. What's vastly more
>> likely is consistent "erosion" over time. First the 3D video drivers,
>> then the wireless network drivers, then the fakeraid drivers, and so on.
> 
> I agree about the erosion.
> 
> I am convinced that the only way to stop the erosion is to totally stop
> buying hardware that has only binary only drivers (unless you buy it to
> create an open source driver or to reverse engineer the binary only
> driver of course! ;).
> 
> For example if a laptop has an embedded wirless or 3d card not supported by
> open source drivers, buy a laptop without any wireless card or without
> 3d, instead of buying one with the not-supported hardware without using
> it (I can guarantee there are still laptops that requires no 3d
> binary only drivers and no wirless cards drivers, even for the winmodems
> you can choose the ones supported by alsa). We literally have to refuse
> buying those cards with binary only kernel drivers.
> 
> Every time we buy a piece of hardware with binary only drivers we admit
> that the binary only driver vendors are doing the right choice for their
> stockholders. Only when we refuse to buy it, we can make a slight difference.
> When we don't buy hardware without open source drivers, we send the
> message to the shareholders that the management is causing them a loss.

The problem with this statement is that Linux users are a drop in the 
bucket of sales for this hardware.  Boycotting doesn't cost the vendors 
enough to make them care.  And this does nothing for people who are 
converting over to Linux, and didn't buy hardware with that 
consideration in mind.

The only way to break the stalemate is to reverse engineer drivers. 
Turning the screws tighter isn't going to make open drivers magically 
appear.  More likely, the vendors will abandon Linux as being too 
hostile and/or too costly to support, leaving everybody back at square one.

--
				Brian Gerst
