Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTIPNUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTIPNUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:20:33 -0400
Received: from maverick.eskuel.net ([81.56.212.215]:19619 "EHLO
	maverick.eskuel.net") by vger.kernel.org with ESMTP id S261864AbTIPNUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:20:31 -0400
Message-ID: <33183.213.193.3.110.1063718429.squirrel@webmail.eskuel.net>
In-Reply-To: <20030916121229.GE585@elf.ucw.cz>
References: <3F660BF7.6060106@eskuel.net> <20030916114822.GB602@elf.ucw.cz> 
     <1063714222.1302.5.camel@teapot.felipe-alfaro.com> 
     <20030916121229.GE585@elf.ucw.cz>
Date: Tue, 16 Sep 2003 15:20:29 +0200 (CEST)
Subject: Re: Nearly succes with suspend to disk in -test5-mm2
From: "Mathieu LESNIAK" <maverick@eskuel.net>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       "LKML " <linux-kernel@vger.kernel.org>, mochel@osdl.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
>
>> > cat you try with echo 4 > /proc/acpi/sleep?
>>
>> It does nothing for me... No messages in the kernel ring, no intention
>> to perform a swsusp.
>
> That's strange; can you cat /proc/acpi/sleep?
>
> 								Pavel

Hi

minimaverick:~# cat /proc/acpi/sleep
S0 S3 S4 S5

Mathieu
