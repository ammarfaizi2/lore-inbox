Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTJZS6d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263404AbTJZS6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:58:33 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:1158 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S263402AbTJZS6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:58:32 -0500
Message-ID: <33134.68.105.173.45.1067195366.squirrel@mail.mainstreetsoftworks.com>
Date: Sun, 26 Oct 2003 14:09:26 -0500 (EST)
Subject: Re: [patch 2.6.0-test9] enable pci id for promise pdc20378 in new libata driver
From: "Brad House" <brad_mssw@gentoo.org>
To: <jgarzik@pobox.com>
In-Reply-To: <3F9C14C9.3090400@pobox.com>
References: <33092.68.105.173.45.1067192069.squirrel@mail.mainstreetsoftworks.com>
        <3F9C14C9.3090400@pobox.com>
X-Priority: 3
Importance: Normal
Cc: <brad_mssw@gentoo.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> You should CC the maintainer of libata :)
>

ok, I'll figure out who that is...

>
>> The patch can be found here:
>> http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-promise20378.patch
>>
>> Patch/Testing done by Caleb Shay <caleb@webninja.com>
>
> Tested in 32-bit mode or 64-bit mode?
>
> I've gotten a report "works in 32-bit, fails in 64-bit".

It was tested in 64bit mode.  Though this particular patch should
have no bearing on 32/64bit, as it just updates the IDs, to allow
the PDC20378 to work.

-Brad


