Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbTLGCok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 21:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTLGCok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 21:44:40 -0500
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:34058
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265288AbTLGCoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 21:44:39 -0500
Message-ID: <3FD24E34.3050300@rogers.com>
Date: Sat, 06 Dec 2003 21:46:28 +0000
From: pZa1x <pZa1x@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
References: <3FC7F031.5060502@rogers.com> <3FC7F2E3.8080109@rogers.com> <20031129082200.A30476@flint.arm.linux.org.uk> <3FC88277.4090304@rogers.com> <20031201210739.C13621@flint.arm.linux.org.uk>
In-Reply-To: <20031201210739.C13621@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.157.208.226] using ID <dw2price@rogers.com> at Sat, 6 Dec 2003 21:43:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please let me know if there's anything I can do to help.

Russell King wrote:
> On Sat, Nov 29, 2003 at 11:26:47AM +0000, pZa1x wrote:
> 
>>(a) with yenta kernel 2.6
>>(b) without yenta kernel 2.6
> 
> 
> Ok, so there aren't any differences between the PCI config space with
> the module loaded and unloaded.  I guess we need to start looking at
> the devices memory space registers for differences.
> 
> (This will require a little more work, so there'll be a slight delay.)
> 


