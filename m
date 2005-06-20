Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVFTRYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVFTRYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVFTRYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 13:24:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44960 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261391AbVFTRYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 13:24:37 -0400
Message-ID: <42B6FBC7.5000900@pobox.com>
Date: Mon, 20 Jun 2005 13:24:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Denis Vlasenko <vda@ilport.com.ua>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com> <200506181806.49627.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua> <20050620164800.GA14798@suse.de>
In-Reply-To: <20050620164800.GA14798@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 20, 2005 at 01:04:10PM +0300, Denis Vlasenko wrote:
> 
>>Greg, any plans to distribute udev and hotplug within kernel tarballs
>>so that people do not need to track such changes continuously?
> 
> 
> Nope.  But if you use udev, you should read the announcements for new
> releases, as I did say this was required for 2.6.12, and gave everyone a
> number of weeks notice :)

Since udev is required for booting, it sounds like you're putting people 
in an upgrade-or-no-boot situation.

That's lame.  The kernel should support udev's out in the field, on 
people's boxes (RHEL, SLES?, Fedora, ...).

	Jeff


