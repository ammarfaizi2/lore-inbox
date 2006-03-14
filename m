Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWCNLl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWCNLl2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 06:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWCNLl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 06:41:28 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:46398 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750974AbWCNLl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 06:41:28 -0500
Message-ID: <4416ABB1.8020802@samwel.tk>
Date: Tue, 14 Mar 2006 12:40:33 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Greg Scott <GregScott@InfraSupportEtc.com>,
       Rick Jones <rick.jones2@hp.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Simon Mackinlay <smackinlay@mail.com>
Subject: Re: Router stops routing after changing MAC Address
References: <925A849792280C4E80C5461017A4B8A20321F9@mail733.InfraSupportEtc.com> <Pine.LNX.4.61.0603131730100.5785@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603131730100.5785@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Mon, 13 Mar 2006, Greg Scott wrote:
> Bzzzzst... Not! There are not any MAC addresses associated with any
> of the intercity links, usually not even in WANs!  MAC is for
> Ethernet! Once you go to fiber, ATM, T-N, etc., there are no MAC addresses.

Bzzzzt. According to WikiPedia:

http://en.wikipedia.org/wiki/MAC_address

MAC addresses are used for:

- Token ring
- 802.11 wireless networks
- Bluetooth
- FDDI
- ATM (switched virtual connections only, as part of an NSAP address)
- SCSI and Fibre Channel (as part of a World Wide Name)

FDDI = fiber, ATM = ATM.

--Bart
