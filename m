Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269039AbRHBSIC>; Thu, 2 Aug 2001 14:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbRHBSHw>; Thu, 2 Aug 2001 14:07:52 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:28941 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S269064AbRHBSHi>;
	Thu, 2 Aug 2001 14:07:38 -0400
Date: Thu, 2 Aug 2001 12:21:43 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA IDE_CS in 2.4.7
In-Reply-To: <E15SMji-000182-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10108021219470.393-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Alan Cox wrote:

> > > Gunther posted this patch ages ago which seems to solve the problem
> > 
> > I will try that. Any reason it did not make it to 2.4.7?
> 
> Andre didnt like it for obscure ATA technical reasons. If it works then
> personally I think its a candidate to go in anyway

Well, without the patch it does *not* work.  I will make sure it functions
with this card.  (Weird finding PCMCIA PCI cards in the electronic camera
supply section.)

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

