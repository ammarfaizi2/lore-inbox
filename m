Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311273AbSCLQeS>; Tue, 12 Mar 2002 11:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311274AbSCLQeJ>; Tue, 12 Mar 2002 11:34:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:51722 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311273AbSCLQeB>; Tue, 12 Mar 2002 11:34:01 -0500
Message-ID: <3C8E2DB6.6090209@evision-ventures.com>
Date: Tue, 12 Mar 2002 17:32:54 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz> <3C8E2A1F.4050607@evision-ventures.com> <20020312172737.B5026@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>>OK the patch looks fine. Taken. Still I have some notes:
>>
>>1. Let's start calling stuff ATA and not IDE. (AT-Attachment is it
>>and not just Integrated Device Electornics.) OK?
>>
> 
> Sure. Feel free to rename whatever file/struct/variable you want. In my
> opinion, it's just not worth caring about whether we call the stuff ATA
> or IDE, both are TLAs with a long history. (Hmm, ATA probably means
> Advanced Technology Attachment, right?)

Basically I would like to try to follow the FreeBSD nomenclature as much as
possible, becouse:

1. I started doing Linux, becouse I like UNIX ;-).
2. It helps (in some distant time) to look at both side by side.
3. It helps to see what has changed "recently".
4. "Learning from the Soviet Union is learning about victory"... just kidding
I'm. But you are from .cz so you already know ;-).

