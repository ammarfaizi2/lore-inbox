Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTKURbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 12:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTKURbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 12:31:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45972 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264376AbTKURbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 12:31:21 -0500
Message-ID: <3FBE4BC7.20605@pobox.com>
Date: Fri, 21 Nov 2003 12:30:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Vojtech Pavlik <vojtech@suse.cz>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120033422.GA8674@bougret.hpl.hp.com> <20031121120534.GA20822@ucw.cz> <20031121172541.GB25453@bougret.hpl.hp.com>
In-Reply-To: <20031121172541.GB25453@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Fri, Nov 21, 2003 at 01:05:34PM +0100, Vojtech Pavlik wrote:
> 
>>On Wed, Nov 19, 2003 at 07:34:22PM -0800, Jean Tourrilhes wrote:
>>
>>
>>>	Excuse me ? Have you looked at the Howto lately ? There is
>>>only Broadcom and Intel which are not supported, which leaves plenty
>>>of choice (including many 802.11g and 802.11a cards).
>>
>>And Realtek (I own one such card) and ADMtek (I bought one by accident
>>in Canada) and Atheros and ... basically anything CardBus doesn't work.
> 
> 
> 	Wrong. There are wireless drivers for RealTek, ADMtek and
> Atheros.
> 	I may repeat myself like a parrot, but "Have you looked at the
> Howto lately ?". I think you exactly prove my point ;-)


Last I checked, none of these were 100% open source.  I am certain this 
is true for Atheros, but IIRC it's also the case for the other two?

Anyway, WRT RealTek, they gave me (and others) docs.  If I can locate a 
card, I'll do a driver (or merge an existing one, if any).  RealTek's 
been pretty supportive of open source in the past, what with 
8139too/8139cp/r8169 stuff.

	Jeff



