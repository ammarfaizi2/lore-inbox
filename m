Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbRFGPTA>; Thu, 7 Jun 2001 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbRFGPSu>; Thu, 7 Jun 2001 11:18:50 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:57327 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S261487AbRFGPSn>; Thu, 7 Jun 2001 11:18:43 -0400
Message-ID: <3B1F9B5A.42BF726D@ameritech.net>
Date: Thu, 07 Jun 2001 10:18:50 -0500
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <15134.53268.965680.167845@pizda.ninka.net>
		<CHEKKPICCNOGICGMDODJMECLDEAA.george@gator.com> <15135.5661.601195.943992@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> George Bonser writes:
>  > There is, of course, one basic problem with that argument. While you can say
>  > (and probably rightly so) that such a change would not be included in Linus'
>  > kernel, I think anyone is allowed to post a patch that might make it
>  > possible to add protocols as modules. If anyone chooses to use it is each
>  > individual's decision but you could not prevent ACME from creating a patch
>  > that allows protocol modules as long as they distributed the patch. Also,  I
>  > know that you are allowed to distribute proprietary modules in binary form
>  > but are there any restrictions on what function these modules can perform?
>  > I don't remember seeing any such restrictions.
> 
> People can post whatever patches which do whatever, sure.
> But this isn't what matters.
> 
> What matters is the API under which a binary-only module may interface
> to the kernel.  Linus specifies that only the module exports in his
> tree fall into this API.
> 
> As I stated in another email, the allowance of binary-only kernel
> modules is a special exception to the licensing of the kernel made by
> Linus.  The GPL by itself, does not allow this at all.
> 
> Later,
> David S. Miller
> davem@redhat.com

David,

   What is your real problem with La Monte's Code.
   I don't buy your more "blessed than thou" argument.
   It is a typical response one normally sees in large
   organizations from folk with "empires" to protect.
   Coming from the "land of warring tribes" firm it is
   a attitude I have seen often.  My response is take 
   a vacation, chill out and reassess.

Watermodem 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
