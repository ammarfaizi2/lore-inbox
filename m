Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRJ0SzE>; Sat, 27 Oct 2001 14:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274757AbRJ0Syy>; Sat, 27 Oct 2001 14:54:54 -0400
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:974 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S274749AbRJ0Syn>; Sat, 27 Oct 2001 14:54:43 -0400
Message-ID: <3BDB031D.34BC4701@mandrakesoft.com>
Date: Sat, 27 Oct 2001 14:55:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Riley H Williams <rhw@MemAlpha.CX>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13 default config
In-Reply-To: <Pine.LNX.4.21.0110271847240.12381-200000@Consulate.UFP.CX>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:
> 
> Hi Alan, Linus.
> 
> The enclosed patch (against the raw 2.4.13 tree) adds a `make defconfig`
> option that configures Linux with the default options obtained by simply
> pressing ENTER to every prompt that comes up.

If someone wishes they can simply 

	cp arch/$arch/defconfig .config
	make oldconfig

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

