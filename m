Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSGHVwL>; Mon, 8 Jul 2002 17:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317180AbSGHVwK>; Mon, 8 Jul 2002 17:52:10 -0400
Received: from 62-190-218-53.pdu.pipex.net ([62.190.218.53]:11788 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S317176AbSGHVwK>; Mon, 8 Jul 2002 17:52:10 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207082159.WAA03443@darkstar.example.net>
Subject: Re: ATAPI + cdwriter problem
To: mistral@stev.org (James Stevenson)
Date: Mon, 8 Jul 2002 22:59:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000901c226ac$dec99b20$0501a8c0@Stev.org> from "James Stevenson" at Jul 08, 2002 07:25:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What's the make and model of your CD-writer?  There are known firmware bugs with a lot of them.

John.

> Hi
> 
> i have  bunch of messages like these and a hung cd writer
> 
> scsi : aborting command due to timeout : pid 28231, scsi0, channel 0, id 2,
> lun 0 Test Unit Ready 00 00 00 00 00
> SCSI host 0 abort (pid 28231) timed out - resetting
> SCSI bus is being reset for host 0 channel 0.
> hdg: ATAPI reset timed-out, status=0xd0
> PDC202XX: Secondary channel reset.
> ide3: reset: success
> hdg: irq timeout: status=0xc0 { Busy }
> hdg: status timeout: status=0xd0 { Busy }
> hdg: drive not ready for command
> 
> 
> anyone be able to suggest any action to help prevent it in the future ?
> 
> thanks
>     James
> 
> --------------------------
> Mobile: +44 07779080838
> http://www.stev.org
>   7:10pm  up 57 min,  3 users,  load average: 2.05, 1.84, 1.10
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

