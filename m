Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293468AbSB1Szq>; Thu, 28 Feb 2002 13:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293163AbSB1Sxb>; Thu, 28 Feb 2002 13:53:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:16141 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293674AbSB1Sud>; Thu, 28 Feb 2002 13:50:33 -0500
Date: Thu, 28 Feb 2002 14:41:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Armin Schindler <mac@melware.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        info@melware.de, petter wahlman <petter@bluezone.no>
Subject: Re: [PATCH] 2.4.18 Eicon ISDN driver fix.
In-Reply-To: <Pine.LNX.4.31.0202270850380.17482-100000@phoenix.one.melware.de>
Message-ID: <Pine.LNX.4.21.0202281441330.2182-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Feb 2002, Armin Schindler wrote:

> The patch below fixes the race condition with copy_to_user and will
> not introduce a new race. What can happen is that two reader-processes
> may get mixed-up messages, but more than one reader isn't allowed here
> anyway.
> 
> Please apply this patch to 2.4 and 2.2, it works for both.

Armin, 

Your patch does not apply cleanly against my tree.

Please regenerate it.

