Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRL2Nzr>; Sat, 29 Dec 2001 08:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282670AbRL2Nzi>; Sat, 29 Dec 2001 08:55:38 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:15109 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S281691AbRL2Nz0>; Sat, 29 Dec 2001 08:55:26 -0500
Message-ID: <3C2DCB40.1030506@humboldt.co.uk>
Date: Sat, 29 Dec 2001 13:55:12 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff <piercejhsd009@earthlink.net>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Does the F--king via 82c686b record at all!!!!!!!!
In-Reply-To: <3C2D317C.ED2A91A6@earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:


> So, DOES ANYBODY HAVE RECORD CAPABILITIES USING THE VIA 82C686B
> CHIP????????
> And if so could you contact me so I might be able to find out the
> problem I have here.

I have successfully recorded using the 686B chip, in a PowerPC embedded 
system. I don't have any PC hardware using the chip to compare this 
with. I recall that a great deal of trial and error was required to work 
out which mixer input corresponded to which socket on the board. This 
was using the kernel driver; I've not attempted ALSA.

-- 
Adrian Cox   http://www.humboldt.co.uk/

