Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282180AbRK1XbX>; Wed, 28 Nov 2001 18:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282179AbRK1XbD>; Wed, 28 Nov 2001 18:31:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54801 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282176AbRK1XbB>; Wed, 28 Nov 2001 18:31:01 -0500
Subject: Re: Linux 2.4.17-pre1
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Wed, 28 Nov 2001 23:39:26 +0000 (GMT)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <200111282200.XAA02802@harpo.it.uu.se> from "Mikael Pettersson" at Nov 28, 2001 11:00:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169EIY-0006UI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> use "BSD without advertising clause", which causes the kernel to be
> tainted. Shouldn't fs/nls/*.c use "Dual BSD/GPL" or "GPL" instead?

Dual BSD/GPL is the correct one.  Not a big issue. Since the GPL allows
stuff to be freer than GPL but still GPL its arguably correct too I suspect
