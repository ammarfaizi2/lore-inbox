Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSDAPYX>; Mon, 1 Apr 2002 10:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311868AbSDAPYO>; Mon, 1 Apr 2002 10:24:14 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:3730 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S311752AbSDAPYA>; Mon, 1 Apr 2002 10:24:00 -0500
Message-ID: <3CA87ABE.9000709@antefacto.com>
Date: Mon, 01 Apr 2002 16:20:30 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joachim Breuer <jmbreuer@gmx.net>
CC: Nerijus Baliunas <nerijus@users.sourceforge.net>,
        Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
	<linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <Pine.SOL.3.96.1020329124320.18653A-100000@virgo.cus.cam.ac.uk>	<ISPFE11QlZFJyUpZ7Nq000037fb@mail.takas.lt> <m3vgbetkc8.fsf@venus.fo.et.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim Breuer wrote:
> Nerijus Baliunas <nerijus@users.sourceforge.net> writes:
> 
> 
>>On Fri, 29 Mar 2002 12:57:07 +0000 (GMT) Anton Altaparmakov <aia21@cus.cam.ac.uk> wrote:
>>
>>[...] Discussion about default fmask, mc, being able to run in place
>>      snipped
>>
>>People using Linux usually keep data files on fat and ntfs permissions, not
>>executables (IMHO).
> 
> 
> For the sake of another vote: Yes, I do use NTFS primarily for data
> storage, and No, I don't like gratuitous x-bits. Not *at all*.

Anton, there have been no votes the other way. What do you think now?

[snip]

> What I would like to see (probably exists somewhere) is a (userland)
> tool which can fire up an exec image residing in a readable (not
> executable) file

ln -s /lib/ld-linux.so.2 /bin/run

Padraig.

