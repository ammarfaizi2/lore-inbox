Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSFNRPg>; Fri, 14 Jun 2002 13:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSFNRPf>; Fri, 14 Jun 2002 13:15:35 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19471 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310206AbSFNRPd> convert rfc822-to-8bit; Fri, 14 Jun 2002 13:15:33 -0400
Message-ID: <3D0A24B4.5060804@evision-ventures.com>
Date: Fri, 14 Jun 2002 19:15:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: axboe@suse.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <UTC200206141709.g5EH9eG29898.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andries.Brouwer@cwi.nl napisa³:
>>Frankly, _I'm_ too scared to run 2.5 IDE currently.
> 
> 
> Backups, that is what you need. Or a scratch machine.
> 
> This is what vanilla 2.5.21 can do to your filesystem
> (after a reboot and a e2fsck -a):
> 
> % ls /lost+found
> #10416
> #104719

> ...
> (thousands and thousands of files - not lost, only their
> names suffered a bit...)
> 
> But, to be fair, only a small part of the damage is due
> to the kernel. Afterwards, e2fsck made things much worse.

Just curious: Becouse dir entires beeing
affected looks like the effect of the recent changes to
the VFS.

