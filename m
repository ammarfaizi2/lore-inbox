Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278001AbRJRTTV>; Thu, 18 Oct 2001 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278098AbRJRTTL>; Thu, 18 Oct 2001 15:19:11 -0400
Received: from mailgw3a.lmco.com ([192.35.35.24]:32516 "EHLO mailgw3a.lmco.com")
	by vger.kernel.org with ESMTP id <S278001AbRJRTS6>;
	Thu, 18 Oct 2001 15:18:58 -0400
Content-return: allowed
Date: Thu, 18 Oct 2001 11:55:53 -0700
From: "Borrelli, Michael J" <michael.j.borrelli@lmco.com>
Subject: Re: Input on the Non-GPL Modules
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Reply-to: mike@nerv-9.net
Message-id: <B094D0875C68D311915500508B0EA6D509EC27F4@emss01m08.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 05:08:13PM +0000, Tony Hoyle wrote: 
> This is still a GPL violation, as the small module couldn't then be 
> linked with the proprietary module. Most companies aren't prepared to 
> get into the legally murky ground that that sort of thing entails.

Where, in the conceptual layers of the kernel, does a peice of code cease to
be a derived work which must also be GPL'ed and become a "normal use" of the
kernel as is allowed by Linus's clause:

"NOTE! This copyright does *not* cover user programs that use kernel
services by normal system calls - this is merely considered normal use of
the kernel, and does *not* fall under the heading of "derived work"."

Cheers,
Mike
