Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSKRQkM>; Mon, 18 Nov 2002 11:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSKRQkM>; Mon, 18 Nov 2002 11:40:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45072 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263137AbSKRQkL>;
	Mon, 18 Nov 2002 11:40:11 -0500
Message-ID: <3DD9198C.60707@pobox.com>
Date: Mon, 18 Nov 2002 11:47:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: Vergoz Michael <mvergoz@sysdoor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <3DD8AD5D.9010803@pobox.com> <3DD8CC44.9060104@domdv.de> <3DD90D88.9020205@pobox.com> <3DD91164.6030007@domdv.de>
In-Reply-To: <028901c28ead$10dfbd20$76405b51@romain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:

> Jeff Garzik wrote:
>
> > That's not going to be fixed by Michael's patch...  Any IOAPIC-related
> > problems cannot be fixed at the driver level, but must be fixed by a
> > BIOS update (or possibly an IOAPIC code fix).  Sometimes vendors do
> > not bother do even wire the IOAPIC when it is a uniprocessor board :(
>
>
> I just wanted to point exactly in that (IO-APIC) direction as a common
> source for trouble.


Oh agreed.  A very annoying, common source of trouble :)

