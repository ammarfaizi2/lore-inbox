Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSBAO7W>; Fri, 1 Feb 2002 09:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291776AbSBAO7M>; Fri, 1 Feb 2002 09:59:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291782AbSBAO7A>; Fri, 1 Feb 2002 09:59:00 -0500
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
To: davem@redhat.com (David S. Miller)
Date: Fri, 1 Feb 2002 15:03:13 +0000 (GMT)
Cc: kaos@ocs.com.au, garzik@havoc.gtf.org, alan@lxorguk.ukuu.org.uk,
        vandrove@vc.cvut.cz, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
In-Reply-To: <20020131.222643.85689058.davem@redhat.com> from "David S. Miller" at Jan 31, 2002 10:26:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WfDe-0005Jd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have a dependency concern, you put yourself in the
> right initcall group.  You don't depend ever on the order within the
> group, thats the whole idea.  You can't depend on that, so you must
> group things correctly.

This was proposed right back at the start. Linus point blank vetoed it.

Alan
