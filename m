Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSHAV1d>; Thu, 1 Aug 2002 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSHAV1d>; Thu, 1 Aug 2002 17:27:33 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55564 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317189AbSHAV1c>; Thu, 1 Aug 2002 17:27:32 -0400
Message-ID: <3D49A75D.801@evision.ag>
Date: Thu, 01 Aug 2002 23:25:49 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
References: <Pine.GSO.4.21.0208011700580.12627-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Thu, 1 Aug 2002, Thunder from the hill wrote:
> 
> 
>>Hi,
>>
>>On Thu, 1 Aug 2002, Alexander Viro wrote:
>>
>>>More powerful?
>>
>>Well, compared to ASCII: it's unlikely that you meet a j letter or a \033 
>>in the size string.
> 
> 
> Huh???  That's a new meaning of "powerful"...  If you mean "more compact"
> I would certainly agree (base-10 instead of base-256), but if _that_ becomes
> a problem with partition tables...  IIRC, OP proposed 4096 bytes for table.
> 
> Again, if somebody really can't check if array of characters is a valid
> representation of integer or can't implement conversion of known valid
> one to its value...  What the devil are you doing here?

Ahh. we are at "devil" arguemnt level... So I will ease myself:
Why the hell don't you rewrite the whole kernel for example in LISP if
you love string processing that much?
I know I know GCC people tryed this in C for a compiler...

