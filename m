Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293258AbSBWXQ4>; Sat, 23 Feb 2002 18:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293259AbSBWXQq>; Sat, 23 Feb 2002 18:16:46 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:15272 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S293258AbSBWXQg> convert rfc822-to-8bit; Sat, 23 Feb 2002 18:16:36 -0500
Message-ID: <3C782531.6050701@wanadoo.fr>
Date: Sun, 24 Feb 2002 00:26:41 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.18-rc4-jam1
In-Reply-To: <20020223234217.C2023@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Hi.
> 
> Version for rc4 is out (easy...):
> 
> http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.18-rc4-jam1/
> 
> Aout reported floppy hangs: I have checked that it hangs even with
> plain 2.4.17, and so have done other people, so I think it is not
> an irqrate-A1 or sched-O1 problem.
> 
> Nobody uses floppy with 2.4.17 ?

stock 2.4.17 works here.
2.4.17-rmap12f-minilowlatency works here too.

i've verified this on 3 PCs :
1/ PIII933 on TUSL2-C (i815ep)
2/ PII350 on BXMaster (i440BX)
3/ Celeron 1.2GHz on TUSL2-C (i815ep)

dunno what is the problem...

François

> Common patterns ?
> 
> Enjoy...
> 
> 



