Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315471AbSEMCEU>; Sun, 12 May 2002 22:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315478AbSEMCET>; Sun, 12 May 2002 22:04:19 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:46905 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S315471AbSEMCES>; Sun, 12 May 2002 22:04:18 -0400
Message-ID: <3CDF1F1B.1090302@mindspring.com>
Date: Sun, 12 May 2002 22:04:11 -0400
From: "John O'Donnell" <johnnyo@mindspring.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.9+) Gecko/20020328
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:

>>[Alexander Viro <viro@math.psu.edu>, May-12 2002, Sun, 18:47 -0400]
>>
>>>On Sun, 12 May 2002, Diego Calleja wrote:
>>>
>>>>>attempt to access beyond end of device
>>>>>08:12: rw=0 want=268574776 limit=8747392
>>>>>
>>>>I'm not an expert, but this perhaps isn't a reiserfs problem.
>>>>
>>>Nope. It looks much more like the IDE problem Tomas Szepe addressed in 
>>>"2.5.15 IDE possibly trying to scribble beyond end of device"
>>>
>>... except that he's using 2.4
>>
>
>Well, judging by
><quote>
>	I use reiserfs on all my filesystems.  I have noticed some minor
>	corruption of files in the past when I didnt shut down Linux properly
>	(lockups, etc).  I experiment alot with my computer.
>
>	Anyway lately I was havin a problem that required frequent reboots.
></quote>
>
>I'd assume this bloke might have booted 2.5.15, only he's not mentioning it.
>
>
>T.
>
I'm sorry.  This IS 2.4.18 - I havent played with 2.5 yet - but thanks 
for the warning.
This is a Seagate ST39102LW hooked into an Adaptec 29160.

I am writing this in my WinDOS 98 mozilla.   I feel so dirty :-)
Well at least it's mozilla. :-)
Johnny O



