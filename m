Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283285AbRLDSou>; Tue, 4 Dec 2001 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283163AbRLDSnO>; Tue, 4 Dec 2001 13:43:14 -0500
Received: from sr3.terra.com.br ([200.176.3.18]:58015 "EHLO sr3.terra.com.br")
	by vger.kernel.org with ESMTP id <S283273AbRLDSmG>;
	Tue, 4 Dec 2001 13:42:06 -0500
Message-ID: <3C0D18F9.4070708@terra.com.br>
Date: Tue, 04 Dec 2001 16:42:01 -0200
From: Piter Punk <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OSS driver cleanups.
In-Reply-To: <Pine.LNX.4.33.0112041146480.24822-100000@netfinity.realnet.co.sz> <3C0CDF3A.2B1AFC56@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:


>>>Out of curiosity, will ALSA also be available on the 24..xx kernels??
>>>Will there be a choice of useing OSS or ALSA??
>>>Will the ALSA drivers be the 0.9 series or the old 0.5 series??? AFAIK they
> 
> IMHO ALSA should -never- go into 2.4.  It's fine as a patch but 2.5 is
> the time for big merges, and since it's already available for 2.4
> outside the kernel there shouldn't be any need for backporting
> 
> 	Jeff

I agree with Jeff. The better choice is wait and make big changes only

in 2.5. If anyone **needs** alsa, is possible download and configure then
outside kernel 2.4. "Stable" series isn't a good place to make experiences...


					Bye,

							Piter PUNK
-- 
   ____________
  / Piter PUNK \_____________________________________________________
|                                                                   |
|      |        E-Mail: piterpk@terra.com.br         (personal)     |
|     .|.               roberto.freires@gds-corp.com (professional) |
|     /V\                                                           |
|    // \\      UIN: 116043354  Homepage: www.piterpunk.hpg.com.br  |
|   /(   )\                                                         |
|    ^`~'^                                                          |
|   #105432                                                         |
`-------------------------------------------------------------------'

