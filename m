Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVAXUDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVAXUDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVAXUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:03:22 -0500
Received: from sherkan.tuxfamily.net ([212.85.158.2]:62093 "EHLO
	mx1.tuxfamily.net") by vger.kernel.org with ESMTP id S261605AbVAXUDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:03:16 -0500
Message-ID: <1294.213.228.34.135.1106596995.squirrel@webmail.tuxfamily.org>
Date: Mon, 24 Jan 2005 21:03:15 +0100 (CET)
Subject: Re: Bug report : drivers/net/hamradio/Kconfig
From: <2df@tuxfamily.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.12[cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Gwe, 2005-01-21 at 07:38, 2df@tuxfamily.org wrote:
>> Hello, i'm translating some Kconfig files to french for the kernelFR
>> project (http://kernelfr.traduc.org), and while i was reading
>> drivers/net/hamradio/Kconfig
>> The kernel is 2.6.10
>>
>> In section : "Baycom ser12 halfduplex driver for AX.25" 9th section,
>> in the 3rdline, there is :
>> "The driver supports the ser12 design in full-duplex mode." instead
>> of "half-duplex mode."
>
> That looks like a bug in the original. I'll double check it, or you
> could send a patch yourself to the trivial patch maintainer.

Wouah, i'm very proud to speak to Alan Cox, so it's my first bug report
on the kernel :)

BUg is also  on the bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=4076

I've also made a patch, my first too :))) :
http://bugzilla.kernel.org/attachment.cgi?id=4450&action=view

I don't know if the patch is correct, but i think

Should I do some other thing ?

Good bye
Simon



