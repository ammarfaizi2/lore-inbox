Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSGLO0e>; Fri, 12 Jul 2002 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316544AbSGLO0e>; Fri, 12 Jul 2002 10:26:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35590 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316538AbSGLO0d> convert rfc822-to-8bit; Fri, 12 Jul 2002 10:26:33 -0400
Message-ID: <3D2EE7BA.8080805@evision-ventures.com>
Date: Fri, 12 Jul 2002 16:29:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Thunder from the hill <thunder@ngforever.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: IDE/ATAPI in 2.5
References: <Pine.SOL.4.30.0207121611170.14389-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Bartlomiej Zolnierkiewicz napisa³:
> On Fri, 12 Jul 2002, Thunder from the hill wrote:
> 
> 
>>Hi,
>>
>>On Fri, 12 Jul 2002, Martin Dalecki wrote:
>>
>>>Against:
>>>
>>>1. Bartlomiej Zolnierkiewcz.
>>
>>What's your reason to vote against him? Something personal?
>>
> 
> 
> I don't vote against him but against stupid changes.
> 
> I try not to mess technical issues with personal ones
> and I have nothing personal to Martin, only technical ;-)
> 
> We can't immediately get rid of ide-cd/floppy/tape.c, look through
> them, then look through ide-scsi.c and sr.c and you will understand why.
> 
> (or not :-( )
> 
> Regards

Workarouns in ide-floppy - ZIP drives and Clock drives.
Workarounds in ide-cd - none.
Workarounds in ide-tape - hopelessly many.

Those are the main "technical issues" which make one hessitate.



