Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbREXOdr>; Thu, 24 May 2001 10:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbREXOdh>; Thu, 24 May 2001 10:33:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28435 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262044AbREXOdc>; Thu, 24 May 2001 10:33:32 -0400
Subject: Re: [PATCH] drivers/net/others
To: tori@unhappy.mine.nu (Tobias Ringstrom)
Date: Thu, 24 May 2001 15:30:17 +0100 (BST)
Cc: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        jgarzik@mandrakesoft.com (Jeff Garzik), akpm@uow.edu.au,
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <Pine.LNX.4.33.0105241035230.10914-100000@boris.prodako.se> from "Tobias Ringstrom" at May 24, 2001 10:45:25 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152w81-00053C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -		printk(version);
> > +		printk("%s", version);
> >
> Could you please explain the purpose of this change?  To me it looks less
> efficient in both performance and memory usage.

its called 'programming in C not taking ugly shortcuts'
> 

