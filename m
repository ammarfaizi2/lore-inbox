Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261958AbTCMBwE>; Wed, 12 Mar 2003 20:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbTCMBwE>; Wed, 12 Mar 2003 20:52:04 -0500
Received: from smtp.cs.curtin.edu.au ([134.7.1.1]:14274 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S261958AbTCMBwD>; Wed, 12 Mar 2003 20:52:03 -0500
Message-ID: <004501c2e904$38a120e0$64070786@synack>
From: "David Shirley" <dave@cs.curtin.edu.au>
To: "Hans-Peter Jansen" <hpj@urpla.net>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <linux-kernel@vger.kernel.org>
References: <041b01c2e86a$870822f0$64070786@synack> <200303121353.h2CDrhu30117@Port.imtp.ilyichevsk.odessa.ua> <002101c2e8a5$8358d4c0$2400a8c0@compaq3> <200303121852.44804.hpj@urpla.net>
Subject: Re: Help, eth0: transmit timed out!
Date: Thu, 13 Mar 2003 09:59:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry

Diferent NIC didn't help.

Yeah we have used about 300 3c905's over the last couple of years
(labs for a university dept). Never had a problem

Must be something else, mem of MB i reckon.

Will change it and let you all know.

Cheers
Dave

----- Original Message -----
From: "Hans-Peter Jansen" <hpj@urpla.net>
To: "David Shirley" <dave@cs.curtin.edu.au>;
<vda@port.imtp.ilyichevsk.odessa.ua>; <linux-kernel@vger.kernel.org>
Sent: Thursday, March 13, 2003 1:52 AM
Subject: Re: Help, eth0: transmit timed out!


> On Wednesday 12 March 2003 15:41, David Shirley wrote:
> > Tried a different NIC, another 3c905c.
>
> ..and? I'm using this NIC family with this driver in all my diskless
setups
> with kernels since 2.0.* up to 2.4.20, and I never experienced the problem
> you describe, so I would check for some hardware, bios, chipset, cable,
hub
> or switch problem.
>
> From about 30 NICs currently in production for 6 month up to 5 years, I
had
> one failure (3c905b). I haven't found Don's driver failing since ages ;-),
> through the b versions created me some headaches for etherbooting and the
> newest 3c905cx-txm has a problem with software bootprom flashing :-(.
>
> Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

