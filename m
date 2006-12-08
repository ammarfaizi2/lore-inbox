Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424100AbWLHDUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424100AbWLHDUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 22:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164391AbWLHDUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 22:20:10 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:60570 "EHLO
	pd5mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164390AbWLHDUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 22:20:09 -0500
Date: Thu, 07 Dec 2006 21:18:23 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
In-reply-to: <fa.aML3aAeWqfac08XNpQa7Zu0AC8w@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Matthias Schniedermeyer <ms@citd.de>, DervishD <lkml@dervishd.net>
Message-id: <4578D97F.7020107@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no>
 <fa.nPT9ZJ5poT8fZx3aWy0MqRK/gto@ifi.uio.no>
 <fa.aML3aAeWqfac08XNpQa7Zu0AC8w@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> Hmmm. That's the only thing that i currently may be doing wrong.
> I have a 1,5 Meter and a 4,5 Meter cable connected to the USB-Controller
> and i only use of them depending on where the HDD is placed in my room,
> the other one is dangling unconnected.
> 
> Then i will unconnect the short cable and use the long cable exclusivly
> and see if it gets better(tm).

That long cable could be part of the problem - I don't think the USB 
specification allows for cables that long (something like a 6 foot max 
as I recall).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

