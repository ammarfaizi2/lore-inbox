Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313452AbSDGTpi>; Sun, 7 Apr 2002 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313455AbSDGTpi>; Sun, 7 Apr 2002 15:45:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24840 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313452AbSDGTph>; Sun, 7 Apr 2002 15:45:37 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: movement@marcelothewonderpenguin.com (John Levon)
Date: Sun, 7 Apr 2002 21:02:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20020407194114.GA21800@compsoc.man.ac.uk> from "John Levon" at Apr 07, 2002 08:41:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uIsI-0006bx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > fixing the code that relies on it (except for the 99% of code relying on it
> > which is cracker authored trojans)
> 
> No doubt, but it's not much harder to look at nm vmlinux or System.map,
> so I don't see the security angle...

Thats not why it was pulled out. Its a deliberate attempt to find out who
is patching the syscall table and sort the results out.

And btw - I've not submitted this to Marcelo, its not something I expect to
see sprung on people in 2.4.19!
