Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291022AbSBSKSp>; Tue, 19 Feb 2002 05:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291027AbSBSKSi>; Tue, 19 Feb 2002 05:18:38 -0500
Received: from monza.eurecom.fr ([193.55.113.133]:27315 "HELO monza.eurecom.fr")
	by vger.kernel.org with SMTP id <S291022AbSBSKS2>;
	Tue, 19 Feb 2002 05:18:28 -0500
Message-ID: <3C722605.3080905@eurecom.fr>
Date: Tue, 19 Feb 2002 11:16:37 +0100
From: Luis Garces <Luis.Garces@eurecom.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel ethernet alias limit
In-Reply-To: <000701c1b929$33a47c60$ab9eef0c@jimws>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Don't know the exact figures, but I was recently able to create more 
than a thousand eth0:X interfaces in a single machine with 2.2.19 
kernels. And it worked perfectly (answer to ping from another host, etc)

Jim Roland wrote:

> I seem to remember back in either Kernel 2.0 or 2.2 there was a limit of 256
> aliases within the ethX aliasing (eg, eth0, then eth0:0 thru eth0:255).
> 
> Has the limit on this been expanded with Kernel 2.4, is it stable and/or
> advised?  I have a need to bind more than 256 addresses to a single
> interface.  Without installing additional network cards.
> 
> Thanks,
> Jim Roland, RHCE
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Luis
****

