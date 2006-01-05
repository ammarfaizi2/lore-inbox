Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWAEQxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWAEQxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbWAEQxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:53:12 -0500
Received: from server1.bhosted.nl ([217.148.95.133]:34066 "HELO bhosted.nl")
	by vger.kernel.org with SMTP id S1751803AbWAEQxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:53:10 -0500
Message-ID: <53367.145.117.21.143.1136479988.squirrel@145.117.21.143>
In-Reply-To: <3888a5cd0601050846i129fd0a5j71d24150b1e0bcd1@mail.gmail.com>
References: <20060103210252.GA2043@vanheusden.com>
    <3888a5cd0601050846i129fd0a5j71d24150b1e0bcd1@mail.gmail.com>
Date: Thu, 5 Jan 2006 17:53:08 +0100 (CET)
Subject: Re: [2.6.15] reproducable hang
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "Jiri Slaby" <lnx4us@gmail.com>
Cc: "Folkert van Heusden" <folkert@vanheusden.com>,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Since 2.6.14 (I also tried 2.6.14.4 and 2.6.15), my pc crashes (hangs)
>> when I set eth1 into promisques mode.
>> The crash (no oops or panic!) does NOT crash when I run tcpdump (or any
>> other
>> traffic monitor) on eth0 or eth2.
>> The eth1 card is a 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24).
>> Receiving/sending data through that card works fine.
> sysrq is defunct? try sysrq-t to trace back the running stack.

Will try that as soon as I'm home (couple of hours). It seems the box
crashed again.


Folkert
... who's going to install that nice hardware watchdog by cleware.de


