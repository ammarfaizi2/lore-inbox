Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTHWOOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTHWOOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 10:14:20 -0400
Received: from main.gmane.org ([80.91.224.249]:19846 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263447AbTHWOOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 10:14:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Charles Lepple <clepple@ghz.cc>
Subject: Re: Problem with memstick for Sony DSC-P9
Date: Sat, 23 Aug 2003 10:14:10 -0400
Message-ID: <bi7srm$4u3$1@sea.gmane.org>
References: <20030823153541.652e1f3f.psycho@rift.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <20030823153541.652e1f3f.psycho@rift.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Börjesson wrote:

> I've got a Sony DSC-P9 digital camera and when trying to use Sony's own
> memstick I can't mount it over USB. When using a Lexar memstick there's
> no problem at all. The error-message I get from mount when trying to
> mount the Sony stick is:
> mount: you must specify the filesystem type
> And when specifying vfat that the Lexar memstick uses I get a wrong
> fs-type error instead.
> Anyone know which filesystem I should use or is it a lost cause getting
> the Sony memstick working?

You might try asking on one of the linux-usb lists:

http://www.linux-usb.org/mailing.html#users

What device name are you using? I vaguely recall a recent discussion 
about using the whole device (e.g. sda) vs. specific partitions (sda1, 
sda2).

-C


