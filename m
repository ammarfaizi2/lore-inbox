Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTEMSqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTEMSqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:46:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12672 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263023AbTEMSqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:46:42 -0400
Date: Tue, 13 May 2003 15:00:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pawan Deepika <pawan_deepika@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: new to network device drivers!!
In-Reply-To: <20030513183746.84104.qmail@web41613.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0305131456370.2332@chaos>
References: <20030513183746.84104.qmail@web41613.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Pawan Deepika wrote:

> Hi all,
>
>  I am new to device drivers. Can anyone suggest me
> some simple network driver examples(which deal with
> real interface)to start with. What H/W details I need
> to know to write a driver on my own.
>
> Any help in this regard is highly appreciated.
>
> Thanks & regards,
> Deepika
>
>

How about /usr/src/linux-whatever/drivers/net/pcnet32.c
This does about all the stuff that a network driver would have
to do. It's also quite readable, obviously written by people
who know how.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

