Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSK2JOw>; Fri, 29 Nov 2002 04:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSK2JOw>; Fri, 29 Nov 2002 04:14:52 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:50113 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP
	id <S266987AbSK2JOv>; Fri, 29 Nov 2002 04:14:51 -0500
Message-ID: <3DE714DB.9020609@terra.com.br>
Date: Fri, 29 Nov 2002 07:18:51 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.23-rc2 & an MCE
References: <20021125202033.A1212@jaquet.dk> <20021126220459.GA229@elf.ucw.cz> <3DE6A0A8.7080501@terra.com.br> <20021129071803.A7602@jaquet.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> I have nothing in my logs but have had three more chrashes since
> my first report. Two of them I couldn't inspect since I was at
> work (the machine is at home) and had my girlfriend boot the box,
> but the last one was identical to the reported one.
> 
> I am getting a new processor now and hope that'll do it.

	Since the MCE code is reporting a instruction fetch error from the 
level 1 cache, it could be a bad ram problem...

	Could you try and run the memtest86 on your memory card(s) first (maybe 
in a different machine)?

	Kind Regards,

Felipe

