Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272315AbSISScm>; Thu, 19 Sep 2002 14:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272320AbSISScm>; Thu, 19 Sep 2002 14:32:42 -0400
Received: from hermes.domdv.de ([193.102.202.1]:40203 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272315AbSISSck>;
	Thu, 19 Sep 2002 14:32:40 -0400
Message-ID: <3D8A194B.8090002@domdv.de>
Date: Thu, 19 Sep 2002 20:36:59 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Stephen Aiken <aikens@colorado.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with 2.4 and 2.5 with KVM/mouse
References: <Pine.LNX.4.44.0209161249420.1769-100000@wild> <1032215605.17016.3.camel@dell_ss3.pdx.osdl.net>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do remember that I have one board in my company that doesn't like KVMs 
at all (please don't ask for the brand, I'm offsite for a while and 
don't remember the type). All other boards connected to KVMs (different 
types) and running Linux 2.4 (various versions) work fine.
So I guess you do have a hardware (board) problem.

Stephen Hemminger wrote:
> No change when gpm is killed and restarted
> 
> On Mon, 2002-09-16 at 11:56, Stephen Aiken wrote:
> 
>>>Now, on my test machine running 2.5 the mouse works until I do a KVM
>>>machine swap. Then the 2.5 machine never clears up the mouse wackiness
>>>and the only choice is to reboot. 
>>
>>Have you tried restarting gpm?
>>
>>-Steve
>>--
>>The day after tomorrow is the third day of the rest of your life.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

