Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315892AbSEGQ3E>; Tue, 7 May 2002 12:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315895AbSEGQ3D>; Tue, 7 May 2002 12:29:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30479 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315892AbSEGQ3C>; Tue, 7 May 2002 12:29:02 -0400
Message-ID: <3CD7F212.5090608@evision-ventures.com>
Date: Tue, 07 May 2002 17:26:10 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <5.1.0.14.2.20020507153451.02381ec0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com> <20020507162010.GA13032@ravel.coda.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jan Harkes napisa?:
> On Tue, May 07, 2002 at 08:36:54AM -0700, Linus Torvalds wrote:
> 
>>On Tue, 7 May 2002, Anton Altaparmakov wrote:
>>
>>>As the new IDE maintainer so far we have only seen you removing one
>>>feature after the other in the name of cleanup, without adequate or even
>>>any at all(!) replacements,
>>
>>Who cares? Have you found _anything_ that Martin removed that was at all
>>worthwhile? I sure haven't.
> 
> 
> I'm still hoping a patch will show up that will allow me to regain
> access to my compactflash cards and IBM microdrive disks. The code
> currently doesn't rescan for new drives when a card has been inserted,
> although it still seems to have all the necessary logic.
> 

Yes I'm fully aware of this, but the whole initialization
is currently much in flux and I will return to this issue back
if I think that things are in shape there. OK?

