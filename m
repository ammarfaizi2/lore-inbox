Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271347AbRIFQcg>; Thu, 6 Sep 2001 12:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271336AbRIFQc1>; Thu, 6 Sep 2001 12:32:27 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:35591 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271347AbRIFQcL>;
	Thu, 6 Sep 2001 12:32:11 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109061626.UAA11353@ms2.inr.ac.ru>
Subject: Re: Laptop problems with Yenta... Workaround...
To: Tester@videotron.CA (Olivier Crete)
Date: Thu, 6 Sep 2001 20:26:08 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109051537430.931-100000@TesterTop.PolyDom> from "Olivier Crete" at Sep 6, 1 00:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I think I found a solution... I can't reproduce the problem when I use the
> independant pcmcia_cs package instead of the drivers that are in the main
> kernel tree...  So the problem is somewhere in the (or triggered by
> yenta)...
> 
> The pcmcia_cs package is at: http://pcmcia-cs.sourceforge.net/
> 
> But, that does not fix yenta....

The problem has been solved.
See subject: "yenta_socket hangs sager laptop in kernel 2.4.6"
in this mail list, starting from August 21. It proposes several
solutions, equally well working.

Alexey
