Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312325AbSCUAr7>; Wed, 20 Mar 2002 19:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312327AbSCUArj>; Wed, 20 Mar 2002 19:47:39 -0500
Received: from ns01.passionet.de ([62.153.93.33]:8085 "HELO
	mail.cgn.kopernikus.de") by vger.kernel.org with SMTP
	id <S312325AbSCUArQ> convert rfc822-to-8bit; Wed, 20 Mar 2002 19:47:16 -0500
Date: Thu, 21 Mar 2002 01:47:09 +0100
From: Manon Goo <manon@manon.de>
Reply-To: Manon Goo <manon@manon.de>
To: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>, linux-kernel@vger.kernel.org
Subject: RE: Hooks for random device entropy generation missing incpqarray.c
Message-ID: <130041.1016675229@[212.18.27.11]>
In-Reply-To: <45B36A38D959B44CB032DA427A6E106401281374@cceexc18.americas.cpqcorp.net>
X-Mailer: Mulberry/2.2.0b3 (Mac OS X)
X-manon-file: sentbox
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK I'll try tell you tomorrwo how iz worked out

--On Mittwoch, 20. März 2002 15:59 Uhr -0600 "Cameron, Steve" 
<Steve.Cameron@COMPAQ.com> wrote:

>
>> I have not tried your patch.  but this is in cpqarray_init()
>> and it is only
>> called when the driver is initilaized.
>> How is the entropy-pool further updated ?
>
> It's done in linux/arch/*/kernel/irq.c.
> for i386, in handle_IRQ_event() function.
>
> -- steve
>


