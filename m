Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTERA7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 20:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTERA7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 20:59:53 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:34763 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S261887AbTERA7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 20:59:52 -0400
Date: Sun, 18 May 2003 12:57:44 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Alan Stern <stern@rowland.harvard.edu>,
       Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
Message-ID: <956154.1053262664@[192.168.1.249]>
In-Reply-To: <Pine.LNX.4.44L0.0305161422280.1310-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305161422280.1310-100000@ida.rowland.org>
X-Mailer: Mulberry/3.0.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, 16 May 2003 2:40 p.m. -0400 Alan Stern 
<stern@rowland.harvard.edu> wrote:

> Not suspending isn't really a big deal.  After all, we would suspend only
> when no devices are plugged in anyway.  Is the PIIX4 chipset used in
> laptops, where the power saving might be important?  That's the only
> reason I can think of for wanting to suspend whenever possible.

Yes, it has been used in laptops (some Gateway models, for instance), but I 
suspect strangely broken configurations of this chip are more common than 
laptops using it, and I don't expect the power saving to be that dramatic. 
Those machines are pretty good for battery life anyway, considering the 
high-end (for the time) configurations.  (btw: I no longer have one)

Andrew
