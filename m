Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTKTFZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbTKTFZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:25:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47022 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264267AbTKTFZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:25:44 -0500
Message-ID: <3FBC5036.3020503@pobox.com>
Date: Thu, 20 Nov 2003 00:25:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com>
In-Reply-To: <20031120040034.GF19856@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Jean Tourrilhes wrote:
> 
>>>	Even better :
>>>		1) go to the Wireless LAN Howto
>>>		2) find a card are supported under Linux that suit your needs
>>>		3) buy this card
>>>	I don't see the point of giving our money to vendors that
>>>don't care about us when there are vendors making a real effort toward
>>>us.
> 
> 
> On Wed, Nov 19, 2003 at 10:26:59PM -0500, Jeff Garzik wrote:
> 
>>Unfortunately that leaves users without support for any recent wireless 
>>hardware.  It gets more and more difficult to even find Linux-supported 
>>wireless at Fry's and other retail locations...
> 
> 
> And what good would it be to have an entire driver subsystem populated
> by binary-only drivers? That's not part of Linux, that's "welcome to
> nvidia hell" for that subsystem too, and not just graphics cards.
> 
> I say we should go the precise opposite direction and take a hard line
> stance against binary drivers, lest we find there are none left we even
> have source to and are bombarded with unfixable bugreports.

Who brought binary drivers into this?  And when I have ever advocated 
binary drivers?

ndiswrapper has one use IMHO (which was pointed out me in this 
thread)... to assist in reverse engineering.

	Jeff



