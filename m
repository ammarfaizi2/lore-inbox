Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278125AbRJ1Kie>; Sun, 28 Oct 2001 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278133AbRJ1KiX>; Sun, 28 Oct 2001 05:38:23 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:41549 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S278125AbRJ1KiM>; Sun, 28 Oct 2001 05:38:12 -0500
Posted-Date: Sun, 28 Oct 2001 10:37:46 GMT
Date: Sun, 28 Oct 2001 10:37:45 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13 default config 
In-Reply-To: <21646.1004231366@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.21.0110281035440.28398-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith.

>> The enclosed patch (against the raw 2.4.13 tree) adds a `make
>> defconfig` option that configures Linux with the default options
>> obtained by simply pressing ENTER to every prompt that comes up.

>> Please apply.

> Please don't. You cannot blindly reply 'y' to all new options, it
> will hang on numbers and strings, the answer has to be context
> sensitive.

Who's replying 'y' to all options? My patch answered by just pressing
ENTER to all options, as you'd've seen if you'd bothered to read it.

> There is already a patch for make allyes, allno, allmod and random
> (but valid) configs in kbuild 2.5. That patch is context sensitive
> and can easily be extended with defconfig.

What does this have to do with my patch?

Best wishes from Riley.

