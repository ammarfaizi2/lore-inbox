Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283527AbRLDVpa>; Tue, 4 Dec 2001 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283526AbRLDVpU>; Tue, 4 Dec 2001 16:45:20 -0500
Received: from [216.211.0.6] ([216.211.0.6]:28813 "EHLO mail.lakeheadu.ca")
	by vger.kernel.org with ESMTP id <S283512AbRLDVpC>;
	Tue, 4 Dec 2001 16:45:02 -0500
Message-ID: <3C0D43DC.6020403@mail.myrealbox.com>
Date: Tue, 04 Dec 2001 16:45:00 -0500
From: "Daniel R. Warner" <drwarner@mail.myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.6) Gecko/20011202
MIME-Version: 1.0
To: Cheryl Homiak <chomiak@chartermi.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via82cxx chipset problem
In-Reply-To: <Pine.LNX.4.40.0112030943110.223-100000@maranatha.chartermi.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cheryl Homiak wrote:

> I tried this question on another list and was told not to try to change my
> mhz speed because I would corrupt my hard drive possibly. But does this
> mean I am actually running at only 33mhz.? This doesn't seem like a viable
> way to run my computer and I am having problems with installing new memory
> that may be related to this. My original message is below; any help would
> be appreciated.
> Thanks.


The PCI bus runs at 33mhz on modern motherboards. Only motherboards made 
to provide "odd" FSB timings (such at 75, 83 mhz) need change this. 
Although your FSB (also known as memory bus) runs at 100, 133 or faster, 
the PCI bus is still running at 33mhz.
The short?
Don't worry about that warning, it's not really a warning :)
-D


