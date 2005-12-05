Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVLESrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVLESrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLESrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:47:11 -0500
Received: from mail.dvmed.net ([216.237.124.58]:24460 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751405AbVLESrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:47:09 -0500
Message-ID: <43948B13.2090509@pobox.com>
Date: Mon, 05 Dec 2005 13:46:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@nospam.otaku42.de
CC: Jiri Benc <jbenc@suse.cz>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>	 <20051205190038.04b7b7c1@griffin.suse.cz> <1133806444.4498.35.camel@gimli>
In-Reply-To: <1133806444.4498.35.camel@gimli>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Michael Renzmann wrote: > Hi. > > On Mon, 2005-12-05 at
	19:00 +0100, Jiri Benc wrote: > >>Why yet another attempt to write
	802.11 stack? Sure, the one currently >>in the kernel is unusable and
	everybody knows about it. But why not to >>improve code opensourced by
	Devicescape some time ago instead of >>inventing the wheel again and
	again? > > > Or, in case there is some unknown objection to the
	mentioned code: use > the 802.11 stack that comes along with MadWifi,
	which provides things > like virtual interfaces (for multiple SSID
	support on one physical card) > and WPA support. > > Although I'm a bit
	biased towards MadWifi, I'd second your suggestion to > make use of the
	Devicescape code. The benefit of having a fully-blown > 802.11 stack in
	the kernel that drivers can make use of has been > discussed before, so
	I won't go into that yet again. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Renzmann wrote:
> Hi.
> 
> On Mon, 2005-12-05 at 19:00 +0100, Jiri Benc wrote:
> 
>>Why yet another attempt to write 802.11 stack? Sure, the one currently
>>in the kernel is unusable and everybody knows about it. But why not to
>>improve code opensourced by Devicescape some time ago instead of
>>inventing the wheel again and again?
> 
> 
> Or, in case there is some unknown objection to the mentioned code: use
> the 802.11 stack that comes along with MadWifi, which provides things
> like virtual interfaces (for multiple SSID support on one physical card)
> and WPA support.
> 
> Although I'm a bit biased towards MadWifi, I'd second your suggestion to
> make use of the Devicescape code. The benefit of having a fully-blown
> 802.11 stack in the kernel that drivers can make use of has been
> discussed before, so I won't go into that yet again.

Use the stack that's already in the kernel.

Encouraging otherwise hinders continued wireless progress under Linux.

	Jeff


