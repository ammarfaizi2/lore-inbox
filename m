Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSIWNSA>; Mon, 23 Sep 2002 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSIWNSA>; Mon, 23 Sep 2002 09:18:00 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:8071 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261346AbSIWNR7>;
	Mon, 23 Sep 2002 09:17:59 -0400
Message-ID: <3D8F15B9.4090405@colorfullife.com>
Date: Mon, 23 Sep 2002 15:23:05 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
CC: linux-kernel@vger.kernel.org, "Rhoads, Rob" <rob.rhoads@intel.com>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree <lmb@suse.de> wrote:
 >
> I fully support the idea to audit the Linux device drivers - using guidelines,
> hardware fault injection, stress testing etc - and fixing any potential bugs.
> This is obviously a very important task, because the drivers are some of the
> most ugly code I've seen in the kernel.
> 

Are there any recipies for stress testing drivers?
I have my own list of stress tests I run on my network drivers, but the 
list is more or less random:

http://www.colorfullife.com/~manfred/net-stress/net-stresstest.txt

--
	Manfred

