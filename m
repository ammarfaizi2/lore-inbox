Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVHTGrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVHTGrv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 02:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHTGru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 02:47:50 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:28356 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1751085AbVHTGrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 02:47:49 -0400
Message-ID: <4306D254.3000401@cs.aau.dk>
Date: Sat, 20 Aug 2005 08:48:52 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa drivers] Creatives X-Fi chip
References: <4305AC77.3010907@cs.aau.dk> <1124491956.25424.95.camel@mindpipe>
In-Reply-To: <1124491956.25424.95.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-08-19 at 11:55 +0200, Emmanuel Fleury wrote:
> 
>>Hi all,
>>
>>I did try to look for Alsa drivers for the new X-Fi chip from Creatives
>>(http://www.tomshardware.com/consumer/20050818/), but I didn't find any.
>>
>>I there something running around this chip ? Or no plan yet ?
> 
> 
> Are these even on the market yet?

If not yet, it will be soon.

> If this is the long awaited emu10k3, then there's a good chance we can
> support it.  But we'll need at the very least a hardware sample from
> Creative.

No, it seems to me to be a totally new chip (ca20k1). I don't think you
can use any existing driver to start with. :-/

As you say, documentation from Creatives about the chip will be needed.

So, there is no project about this yet ?

Regards
-- 
Emmanuel Fleury

Assistant Professor          | Office: B1-201
Computer Science Department, | Phone:  +45 96 35 72 23
Aalborg University,          | Mobile: +45 26 22 98 03
Fredriks Bajersvej 7E,       | E-mail: fleury@cs.aau.dk
9220 Aalborg East, Denmark   | URL: www.cs.aau.dk/~fleury
