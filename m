Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280827AbRKGPja>; Wed, 7 Nov 2001 10:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRKGPjT>; Wed, 7 Nov 2001 10:39:19 -0500
Received: from viper.haque.net ([66.88.179.82]:7055 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S280827AbRKGPjG>;
	Wed, 7 Nov 2001 10:39:06 -0500
Date: Wed, 7 Nov 2001 10:38:58 -0500
Subject: Re: kernel 2.4.14 compiling fail for loop device
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: troy@holstein.com, rml@tech9.net, mfedyk@matchmail.com, jimmy@mtc.dhs.org,
        linux-kernel@vger.kernel.org
To: barryn@pobox.com
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <20011107151204.7E53389816@pobox.com>
Message-Id: <8F7F4C29-D395-11D5-A006-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, November 7, 2001, at 10:12 AM, Barry K. Nathan wrote:

>> When I did, and used a looped an iso image, eventually my
>> computer froze up.  Using the actual cd, it did not.  So my
>> personal answer would be no.
>
> Hmmm... my *root* filesystem (with /usr, /home, etc. all on it) on one 
> of
> my computers is loop mounted, and I've not had such a freeze with 2.4.14
> and the two lines removed... Just another data point.

Hrm. I just did some stuff on a fs mounted via loopback and no problems.

Mike: it's something in particular you were doing that triggered it or 
something else completely?

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://wm.themes.org/
                                                batmanppc@themes.org
=====================================================================

