Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310515AbSCLLCA>; Tue, 12 Mar 2002 06:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310548AbSCLLBu>; Tue, 12 Mar 2002 06:01:50 -0500
Received: from [195.63.194.11] ([195.63.194.11]:35079 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310515AbSCLLBg>; Tue, 12 Mar 2002 06:01:36 -0500
Message-ID: <3C8DDFC8.5080501@evision-ventures.com>
Date: Tue, 12 Mar 2002 12:00:24 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vojtech.

I have noticed that the ide-timings.h and ide_modules.h are running
much in aprallel in the purpose they serve. Are the any
chances you could dare to care about propagating the
fairly nice ide-timings.h stuff in favour of
ide_modules.h more.

BTW.> I think some stuff from ide-timings.h just belongs
as generic functions intro ide.c, and right now there is
nobody who you need to work from behind ;-).

So please feel free to do the changes you apparently desired
to do a long time ago...

