Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHHpP>; Thu, 8 Feb 2001 02:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBHHpG>; Thu, 8 Feb 2001 02:45:06 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:21426 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129032AbRBHHot>; Thu, 8 Feb 2001 02:44:49 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102080742.f187gqK01498@devserv.devel.redhat.com>
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
To: ionut@moisil.cs.columbia.edu (Ion Badulescu)
Date: Thu, 8 Feb 2001 02:42:52 -0500 (EST)
Cc: vido@ldh.org, torvalds@transmeta.com, alan@redhat.com,
        linux-kernel@vger.kernel.org, saw@saw.sw.com.sg (Andrey Savochkin)
In-Reply-To: <200102080723.f187N1v17541@moisil.dev.hydraweb.com> from "Ion Badulescu" at Feb 07, 2001 11:23:01 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's the printk that gets it wrong, although that's harmless.
> Intel's documentation states that the bug does NOT exist if the
> bits 0 and 1 in eeprom[3] are 1. Thus, the workaround is correct,
> the printk is wrong.

So why does it fix the problem for him. His report and your reply don't
make sense viewed together

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
