Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136455AbREDRBt>; Fri, 4 May 2001 13:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136457AbREDRBk>; Fri, 4 May 2001 13:01:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11790 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136455AbREDRBd>; Fri, 4 May 2001 13:01:33 -0400
Subject: Re: Possible PCI subsystem bug in 2.4
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 4 May 2001 18:04:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <m17kzxnlbv.fsf@frodo.biederman.org> from "Eric W. Biederman" at May 04, 2001 10:13:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vj0V-0007ek-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seriously.  With the general attitude of distrusting BIOS's I have
> been amazed at the number of things linux expects the BIOS to get
> right.  In practice windows seem to trust the BIOS much less than
> linux does.

It becomes more and more obvious over time exactly why. One problem however
is that windows gets away with this because many vendors ship random extra
gunge for their box with the system. We dont yet have that power

Alan

