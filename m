Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315837AbSEGOi4>; Tue, 7 May 2002 10:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315841AbSEGOiz>; Tue, 7 May 2002 10:38:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10509 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315837AbSEGOiz>; Tue, 7 May 2002 10:38:55 -0400
Message-ID: <3CD7D842.8040003@evision-ventures.com>
Date: Tue, 07 May 2002 15:36:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
In-Reply-To: <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk> <3CD7C9F1.2000407@evision-ventures.com> <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020507151627.02390bd0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Anton Altaparmakov napisa?:

> 
> [aia21@drop hda]$ ideinfo
> bash: ideinfo: command not found
> 
> Obviously distros haven't caught up with this development. )-:
> 
> Care to give me a URL? A quick google for "ideinfo Linux download" 
> didn't bring up anything looking relevant.

http://www.j2.ru/frozenfido/ru.unix.bsd/1329707b3e3f8.html

Porting it should be fairly tirvial. Basically lspci +
the parsing crap.

> 
> I like text parsing... It is not performance critical and makes info 
> human readable... Whether existing text parsers are any good or not, I 
> don't care, write a better one if you don't like the existing one or go 
> beat up the people who wrote the bad ones... That seems to be Martin's 
> standard reply, so I thought I would use it, too. (-;

Feel free to do it yourself - in user space where it belongs.

