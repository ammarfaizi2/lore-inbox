Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRAYUGj>; Thu, 25 Jan 2001 15:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129311AbRAYUG3>; Thu, 25 Jan 2001 15:06:29 -0500
Received: from ruddock-157.caltech.edu ([131.215.90.157]:63243 "EHLO
	alex.caltech.edu") by vger.kernel.org with ESMTP id <S129235AbRAYUGO>;
	Thu, 25 Jan 2001 15:06:14 -0500
Date: Thu, 25 Jan 2001 12:07:30 -0800
From: David Bustos <bustos@its.caltech.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: es1371 freezes 2.4.0 hard
Message-ID: <20010125120729.A516@alex.caltech.edu>
In-Reply-To: <20010124154457.A491@alex.caltech.edu> <3A70451D.C599794A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A70451D.C599794A@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jan 25, 2001 at 10:24:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Jeff Garzik on Thu, Jan 25, 2001 at 10:24:13AM -0500:
> What happens if you remove the call to pci_enable_device() in the source
> code, drivers/sound/es1371.c?

That seems to do it.


Thanks,
David Bustos
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
