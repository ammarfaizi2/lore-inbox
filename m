Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbSAZP0a>; Sat, 26 Jan 2002 10:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285273AbSAZP0Y>; Sat, 26 Jan 2002 10:26:24 -0500
Received: from smtp2.libero.it ([193.70.192.52]:13484 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S285226AbSAZP0L>;
	Sat, 26 Jan 2002 10:26:11 -0500
From: Andrea Ferraris <andrea_ferraris@libero.it>
Reply-To: andrea_ferraris@libero.it
Date: Sat, 26 Jan 2002 16:24:23 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <3C51E36B.6296299D@mandrakesoft.com> <0201261111500C.01074@af>
In-Reply-To: <0201261111500C.01074@af>
Subject: OPS: eth0: NULL pointer encountered in RX ring, skipping
MIME-Version: 1.0
Message-Id: <02012616242303.03848@af>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saturday 26 January 2002 11:11, Andrea Ferraris scrisse:
> Friday 25 January 2002 23:59, Jeff Garzik scrisse:
> > Well, the code says "this should never happen" ;-)
> >
> > But anyway, it is probably a temporary memory allocation failure.  The
> > code handles this case.
>
> Yes, but I think that isn't normal to have to do a cold reboot to have the
> machine again working on the network. It is, maybe that the code doesn't
> handle so well this case. Do you suggest a kernel upgrade?

Ops ... sorry. It was a 2.2.16 kernel.

Andrea
