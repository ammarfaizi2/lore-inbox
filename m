Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271933AbTGYGpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271934AbTGYGpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:45:10 -0400
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:10255 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP id S271933AbTGYGpG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:45:06 -0400
Message-ID: <7075.212.153.94.193.1059116415.squirrel@webmail.xs4all.nl>
In-Reply-To: <20030725065507.26549.qmail@web14208.mail.yahoo.com>
References: <20030725065507.26549.qmail@web14208.mail.yahoo.com>
Date: Fri, 25 Jul 2003 09:00:15 +0200 (CEST)
Subject: Re: kernel 2.6.0-test1 refuses to boot on a PC with AMD Athlon XP 
     1800+
From: "Jurriaan Kalkman" <thunder7@xs4all.nl>
To: "Manjunathan Padua Yellappan" <manjunathan_py@yahoo.com>
Cc: linux-kernel@vger.kernel.org, manjunathan_py@yahoo.com
Reply-To: thunder7@xs4all.nl
User-Agent: SquirrelMail/1.4.2 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Folks,
>
> I compiled the latest version of the kernel
> 2.6.0-test1.
>
> I was able to successfully build the bzImage , but I
> am not able to boot using this new kernel.
> My Machine just stops after displaying the following
>
>     "Uncompressing Linux... Ok, booting the kernel "
>
> Nothing happens after this message, it just hangs
>
> Please assist me in solving this, I am very keen on to
> testing this kernel.
>
> Configuration of my machine :
> CPU  AMD Athlon 1800+ XP
> Motherboard ASUS KT266
> RAM  256MB
> HDD  20GB
> with ATI Rage128 AGP card
>
> Thanks in advance.
> Manjunathan Padua Y
>
> Note: Please cc your responses to this email id.
>
There have been several reports like this. Please double check your
.config, and search in the archives to find out how to enable your console
and your keyboard etc. It is somewhat non-obvious at the moment.

HTH,
Jurriaan
