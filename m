Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTB0UUB>; Thu, 27 Feb 2003 15:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTB0UUA>; Thu, 27 Feb 2003 15:20:00 -0500
Received: from mail.spylog.com ([194.67.35.220]:37799 "EHLO mail.spylog.com")
	by vger.kernel.org with ESMTP id <S266948AbTB0UT7>;
	Thu, 27 Feb 2003 15:19:59 -0500
Date: Thu, 27 Feb 2003 23:30:13 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100: wait_for_cmd_done timeout
Message-ID: <20030227203013.GA25009@an.spylog.com>
Mail-Followup-To: Andrey Nekrasov <andy@spylog.ru>,
	linux-kernel@vger.kernel.org
References: <01e601c2de81$27527ce0$3f00a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <01e601c2de81$27527ce0$3f00a8c0@witbe>
Organization: SpyLOG ltd.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul Rolland,

> Feb 27 13:50:01 rms-01 Feb 27 13:50:01:30726 kernel: eepro100:
> wait_for_cmd_done
>  timeout!
> 
> eth0: OEM i82557/i82558 10/100 Ethernet, 00:06:5B:39:69:2B, IRQ 16.
>   Board assembly 02d484-000, Physical connectors present: RJ45
>   Primary interface chip i82555 PHY #1.
>   General self-test: passed.
>   Serial sub-system self-test: passed.
>   Internal registers self-test: passed.
>   ROM checksum self-test: passed (0x04f4518b).
> Anyone knows why ?

 try update bios on motherboard.
 i am use INTEL STL2 and after update bios to last version network card work ok

-- 
Any statement is incorrect.
