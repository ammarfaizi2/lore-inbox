Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVLBQCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVLBQCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVLBQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:02:50 -0500
Received: from mail.tmr.com ([64.65.253.246]:5785 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750802AbVLBQCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:02:50 -0500
Message-ID: <4390730F.8000909@tmr.com>
Date: Fri, 02 Dec 2005 11:15:11 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>	 <20051123233016.4a6522cf.pj@sgi.com>	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>	 <200512020849.28475.vda@ilport.com.ua> <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
In-Reply-To: <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

> This is a reason why enums are worse than #defines.
> 
> Unlike in other languages, C enum is not much useful in practices.

Actually they are highly useful if you know how to use them. They allow 
type checking, have auto increment, and are part of the language instead 
  of a feature of the preprocessor.

> Maybe the designer wanted C to be as fancy as other languages?  C
> shouldn't have had enum imho. Anyway we don't have any strong motives
> to switch to enums.

The last sentence seems correct in spite of your misunderstanding of how 
and why enums are used and useful. Like a driver who mis-read a map 
wandering aimlessly and lost, you have come to the correct destination 
by accident.

> --
> Coywolf Qi Hunt
> http://sosdg.org/~coywolf/

It would have been good to use enums in the first place, I can't see 
changing now because of the effort involved.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
