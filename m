Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWGHRr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWGHRr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWGHRr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:47:59 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14244 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964915AbWGHRr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:47:58 -0400
Subject: Re: [PATCH 2.6.18-rc1 1/1] arch/x86-64: A few trivial spelling and
	grammar fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Henley <adamazing@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, trivial@kernel.org,
       ak@suse.de
In-Reply-To: <c526a04b0607081027j62887e9bi5a3b93fa4606e003@mail.gmail.com>
References: <c526a04b0607081027j62887e9bi5a3b93fa4606e003@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 08 Jul 2006 19:04:54 +0100
Message-Id: <1152381894.27368.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-08 am 18:27 +0100, ysgrifennodd Adam Henley:
> -	 * have much chances to find a place in the lower 4GB of memory.
> +	 * have much chance of finding a place in the lower 4GB of memory.
>  	 * Unfortunately we cannot move it up because that would make the
>  	 * IOMMU useless.

OK (just s/chance/chance/ is enough)

> -	 * Some unknown Intel IO/APIC (or APIC) errata is biting us with
> +	 * Some unknown Intel IO/APIC (or APIC) errata are biting us with

Yes

> -	 * we might want to decouple profiling from the 'long path',
> +	 * We might want to decouple profiling from the 'long path',
>  	 * and do the profiling totally in assembly.

Yes

> -	 * all of that that no need to invent something new.
> +	 * all of that, no need to invent something new.

Yes (or that. There is no need)

Alan

