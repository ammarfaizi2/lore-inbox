Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSFERuy>; Wed, 5 Jun 2002 13:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSFERux>; Wed, 5 Jun 2002 13:50:53 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:41601 "EHLO
	coredump.electro-mechanical.com") by vger.kernel.org with ESMTP
	id <S315690AbSFERuw>; Wed, 5 Jun 2002 13:50:52 -0400
Date: Wed, 5 Jun 2002 13:46:25 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: promise PDC20267 onboard supermicro P3TDDE
Message-ID: <20020605134625.B26891@coredump.electro-mechanical.com>
In-Reply-To: <20020605132018.A4803@coredump.electro-mechanical.com> <1023302356.2443.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Removing the hdd from the controller and it boots just fine.  I tried a
> > Quantum fireball lct10 05 and a seagate st34311a with the same results.
> > 
> > The bios on the pdc controller is v1.31
> 
> When 2.4.19pre10-ac2 appears please try that. I've merged a couple of
> small fixes from Promise (not all the ones they want sorting - some of
> it is a bit hairy so I'll let Andre do that 8))

Ok.  where do I get the ac patches at?  It's been a long time since I tried
one.
