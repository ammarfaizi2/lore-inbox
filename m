Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVJELYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVJELYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 07:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJELYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 07:24:30 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:36028 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S932624AbVJELY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 07:24:29 -0400
Message-ID: <4343B779.8030200@cs.aau.dk>
Date: Wed, 05 Oct 2005 13:22:33 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: freebox possible GPL violation
References: <20051005111329.GA31087@linux.ensimag.fr>
In-Reply-To: <20051005111329.GA31087@linux.ensimag.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok, I think this is cristal clear to me, now. :)

Pierre Michon wrote:
> 
> The fimware that is used with the freebox is a Linux system.
> So in the firmware there is the GPL Linux kernel and all the GPL software 
> listed on [1] (busybox for example).
> 
> Users can't download nor binary firmware nor source code of GPL
> software.
> 
> The binary firmware is downloaded by the freebox when a new version is
> available. This is done on an unknow server with an unknow protocol.
> 
> So free keep the Linux kernel modification they have made. You could
> see some of the log of their modification on [2] and [3].
> They also don't provide the source for the GPL userspace software they
> include in the firmware.

Your task will be to prove that the kernel they upload to your box is a
modified Linux kernel (by "modified Linux kernel", I mean no modules but
the kernel itself).

So, the first step would be to catch/sniff this binary image, then
analyze it.

But, as long as you cannot prove that Free has done internal
modifications to the Linux kernel which are not released in any way,
your case is quite thin.

Regards
-- 
Emmanuel Fleury

Don't speculate - benchmark.
  -- Dan Bernstein
