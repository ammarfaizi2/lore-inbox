Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129912AbRAaBbr>; Tue, 30 Jan 2001 20:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132795AbRAaBbh>; Tue, 30 Jan 2001 20:31:37 -0500
Received: from quechua.inka.de ([212.227.14.2]:1637 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129912AbRAaBbZ>;
	Tue, 30 Jan 2001 20:31:25 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
Message-Id: <E14Nm7J-0001Ot-00@sites.inka.de>
Date: Wed, 31 Jan 2001 02:31:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101310008.f0V08Wv23250@localhost.localdomain> you wrote:
> 256, in later 2.4.* kernel releases?  That would allow this customer to
> work with an unpatched kernel, at the cost of an additional 3.5 kB of
> variables in the kernel.

Don't think this is fairly common. So especially since I consider that kind of
hardware (what is it) to require finetuning ("enterprise kernel") anyway,
there is no real gain out of it, as long as the structure is not dynamically.

Is that some kind of file server or masspar system? Intel?

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
