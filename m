Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWFOAuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWFOAuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWFOAuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:50:08 -0400
Received: from gw.goop.org ([64.81.55.164]:17617 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751284AbWFOAuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:50:06 -0400
Message-ID: <4490AEAE.7060908@goop.org>
Date: Wed, 14 Jun 2006 17:49:50 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Kevin Lloyd <klloyd@sierrawireless.com>, linux-kernel@vger.kernel.org
Subject: Re: New VID/PID combos for airprime driver and WWAN support
References: <3415E2A2AB26944B9159CDB22001004D19DE66@nestea.sierrawireless.local> <20060614231459.GA23025@suse.de>
In-Reply-To: <20060614231459.GA23025@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> You can just send me patches with the new device ids, in the format
> described in Documentation/SubmittingPatches, and that will get the new
> devices supported properly.
>
> I also have a few questions as to the speed of the current driver (it
> sucks).  I have a patch that was posted to the linux-usb-devel mailing
> list to improve this, but it's only working for about half of the users.
> Are there differences with the different airprime devices that we should
> be aware of?
>
> Anything else that you feel that would help make the driver better would
> be greatly appreciated.
>   

Details on how to get to get stuff like signal strength (while 
connected), text messaging, and so on would be nice.  I presume they're 
available through the other two USB endpoints somehow...

But good basic data throughput is the priority, of course.

    J
(MC5720 user)
