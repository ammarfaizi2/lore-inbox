Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136161AbRDVO55>; Sun, 22 Apr 2001 10:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136162AbRDVO5h>; Sun, 22 Apr 2001 10:57:37 -0400
Received: from B0ed2.pppool.de ([213.7.14.210]:5896 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id <S136161AbRDVO5c>;
	Sun, 22 Apr 2001 10:57:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4.3ac11] clock timer configuration lost - probably a VIA686a motherboard
Date: Sun, 22 Apr 2001 16:56:37 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Andreas Neidhardt <a-neidhardt@foni.net>
In-Reply-To: <E14rJGD-0005lO-00@the-village.bc.nu>
In-Reply-To: <E14rJGD-0005lO-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01042216563700.00857@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 22. April 2001 14:46 schrieb Alan Cox:
> > I got a lot of messages while continuous writing / reading datas from one
> > a harddisk to another harddisk (both at 1. ide-channel) during backup
> > with rsync. Both harddisks use udma4. The data-stream was between 0,5
> > MB/s and 20MB/s.
> > I never got these messages before and after the backup finished I
> > couldn't see them anymore.
>
> Thy do trigger to easily. Im still investigating that

I just read in a german newsgroup from another user, having the same problem, 
but not with a VIA-chipset, but with a GA-5AX with Ali V Chipsatz +  iP 200 
MMX. Unfortunately he didn't tell, which kernel he's using and at which 
situation the message occurs.

Regards,
Andreas Hartmann
