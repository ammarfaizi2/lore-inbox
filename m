Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSGHR7w>; Mon, 8 Jul 2002 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSGHR7v>; Mon, 8 Jul 2002 13:59:51 -0400
Received: from mail7.svr.pol.co.uk ([195.92.193.21]:47136 "EHLO
	mail7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316899AbSGHR7u>; Mon, 8 Jul 2002 13:59:50 -0400
Posted-Date: Mon, 8 Jul 2002 17:45:02 GMT
Date: Mon, 8 Jul 2002 18:44:55 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Justin Hibbits <jrh29@po.cwru.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Elizabeth Chastain <mec@shout.net>
Subject: Re: Patch for Menuconfig script
In-Reply-To: <20020708151412.GB695@opus.bloom.county>
Message-ID: <Pine.LNX.4.21.0207081841380.9595-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom.

>>> This is just a patch to the Menuconfig script (can be easily adapted
>>> to the other ones) that allows you to configure the kernel without
>>> the requirement of bash (I tested it with ksh, in POSIX-only mode).  
>>> Feel free to flame me :P

>> Does it also work in the case where the current shell is csh or tcsh
>> (for example)?

> Er.. why wouldn't it?
> $ head -1 scripts/Menuconfig 
> #! /bin/sh

> So this removes the /bin/sh is not bash test, yes?

 Q> # ls -l /bin/sh | tr -s '\t' ' '
 Q> lrwxrwxrwx 1 root root 4 May 7 1999 /bin/sh -> tcsh
 Q> #

You tell me - the above is from one of the systems I regularly use,
which does not even have bash installed...

Best wishes from Riley.

