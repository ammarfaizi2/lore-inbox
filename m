Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSKRQCC>; Mon, 18 Nov 2002 11:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSKRQCC>; Mon, 18 Nov 2002 11:02:02 -0500
Received: from hermes.domdv.de ([193.102.202.1]:19472 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262806AbSKRQCC>;
	Mon, 18 Nov 2002 11:02:02 -0500
Message-ID: <3DD91164.6030007@domdv.de>
Date: Mon, 18 Nov 2002 17:12:20 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Vergoz Michael <mvergoz@sysdoor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <3DD8AD5D.9010803@pobox.com> <3DD8CC44.9060104@domdv.de> <3DD90D88.9020205@pobox.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> That's not going to be fixed by Michael's patch...  Any IOAPIC-related 
> problems cannot be fixed at the driver level, but must be fixed by a 
> BIOS update (or possibly an IOAPIC code fix).  Sometimes vendors do not 
> bother do even wire the IOAPIC when it is a uniprocessor board :(

I just wanted to point exactly in that (IO-APIC) direction as a common 
source for trouble.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

