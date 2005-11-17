Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbVKQBcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbVKQBcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbVKQBcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:32:53 -0500
Received: from mail.suse.de ([195.135.220.2]:42925 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161071AbVKQBcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:32:53 -0500
From: Andreas Schwab <schwab@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: 64K pages support
References: <1130915220.20136.14.camel@gaston>
	<1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de>
	<20051109201720.GB5443@w-mikek2.ibm.com>
	<1131568336.24637.91.camel@gaston>
	<1131573556.25354.1.camel@localhost.localdomain>
	<1131573693.24637.109.camel@gaston>
	<1131574051.25354.3.camel@localhost.localdomain>
	<20051116230820.GA29068@suse.de>
	<1132183002.24066.90.camel@localhost.localdomain>
	<20051116232720.GA29512@suse.de>
X-Yow: OKAY!!  Turn on the sound ONLY for TRYNEL CARPETING,
 FULLY-EQUIPPED R.V.'S and FLOATATION SYSTEMS!!
Date: Thu, 17 Nov 2005 02:32:45 +0100
In-Reply-To: <20051116232720.GA29512@suse.de> (Olaf Hering's message of "Thu,
	17 Nov 2005 00:27:20 +0100")
Message-ID: <je64qs83eq.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

>  On Wed, Nov 16, Badari Pulavarty wrote:
>
>> I think I am using SLES9. Planning to update to SP3.
>> 
>> # rpm -qi glibc | head
>> Name        : glibc                        Relocations: (not
>> relocatable)
>> Version     : 2.3.3                             Vendor: SuSE Linux AG,
>> Nuernberg, Germany
>> Release     : 98.28                         Build Date: Wed Jun 30
>> 15:55:45 2004
>
> The release number indicates the GA glibc.spec was used, but the
> build date indicates its slightly older than SLES9 GA.

Build date is local time (timezone has been chopped off here).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
