Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbQKBUxO>; Thu, 2 Nov 2000 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129179AbQKBUwy>; Thu, 2 Nov 2000 15:52:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129134AbQKBUwt>; Thu, 2 Nov 2000 15:52:49 -0500
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
To: Tim@Rikers.org (Tim Riker)
Date: Thu, 2 Nov 2000 20:53:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A01BB7D.B084B66@Rikers.org> from "Tim Riker" at Nov 02, 2000 12:07:41 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rRMc-0001sX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That need to run Linux - name one ? Why try to solve a problem when it hasn't
> > happened yet. Let whoever needs to solve it do it.
> 
> We have proposals here all under NDA. So I won't mention one of them.
> Perhaps there are some of these folk on the list that would like to
> comment?

Then I think it will be up to you to achieve the non gcc build or to teach
your compiler gcc extensions (which may or may not be easier). The kernel also
tends to know a few things about how gcc optimises code which shouldn't matter
if your compiler is good enough to optimise nicely anyway.

AFAIK the only non gcc port of Linux isnt exactly a port but was ELKS done using
bcc86 (Bruce Evans compiler)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
