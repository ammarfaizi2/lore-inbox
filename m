Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318688AbSHAJm6>; Thu, 1 Aug 2002 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318687AbSHAJl5>; Thu, 1 Aug 2002 05:41:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14596 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318688AbSHAJjs>; Thu, 1 Aug 2002 05:39:48 -0400
Message-ID: <3D484C0F.3070609@evision.ag>
Date: Wed, 31 Jul 2002 22:43:59 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
References: <200207310746.AAA07831@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> I wrote:
> 
>>       I'd be intersted in knowing what one of those other problems
>>is.  Otherwise, I don't understand why I can't eliminate the "lock
>>group" stuff.
> 
> 
> 	Nevermind.  I see that the "lock group" code is used
> to implement the "serialize" IDE option.

Yes. I was a bit lazy in explaining this. (Deliberately
asking you for a disaster experiment.) Call me evil :-).



