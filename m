Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbULTQTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbULTQTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbULTQTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:19:16 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:34323 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261560AbULTQTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:19:12 -0500
Message-ID: <41C6FB79.8030101@tebibyte.org>
Date: Mon, 20 Dec 2004 17:19:05 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac16
References: <41C2FF09.5020005@tebibyte.org>	 <1103222616.21920.12.camel@localhost.localdomain>	 <1103349675.27708.39.camel@tglx.tec.linutronix.de>	 <41C448BB.1020902@tmr.com>	 <Pine.LNX.4.61.0412181606050.21338@yvahk01.tjqt.qr> <1103554123.30268.19.camel@localhost.localdomain>
In-Reply-To: <1103554123.30268.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox escreveu:
> Or boot with mem=. I actually do test runs with -ac on a 128Mb box with
> about 16Mb of that stolen as video ram. 2.6.9 isn't behaving perfectly
> but seems reasonably ok for most loads except brokenoffice

What sort of reasonably OK? My experience on my 64MB P2-350 Dell 
Optiplex is that 2.6.9-acXX will kill things off at random even when the 
machine isn't out of memory. If you have any particular test cases you 
would like run just ask, I understand that some of the difficulty is 
that the VM developers have machines plenty big enough not to suffer the 
problems.

The embedded market is different, we're not likely to see multi-gigabyte 
mobile phones, PDAs, PVRs or whatever for a while at least. 64MB is not 
*that* small.

Regards,
Chris R.
