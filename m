Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276099AbRJUOX2>; Sun, 21 Oct 2001 10:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276118AbRJUOXT>; Sun, 21 Oct 2001 10:23:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7952 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276099AbRJUOXD>; Sun, 21 Oct 2001 10:23:03 -0400
Subject: Re: Input on the Non-GPL Modules
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Sun, 21 Oct 2001 15:28:49 +0100 (BST)
Cc: greearb@candelatech.com (Ben Greear), alan@lxorguk.ukuu.org.uk (Alan Cox),
        jan@gondor.com (Jan Niehusmann), linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011020231347.00b81ef8@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Oct 20, 2001 11:20:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vJar-0006Ug-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And even if yes, one could just implement the "shim GPL piece" as a server 
> with an exported binary access interface (use of a CORBA implementation 
> springs to mind for example) and the non-GPL code then functions as a 
> client to the server. Nobody can say that that is not legal. Otherwise you 
> would have to demand that all network clients accessing Linux servers 
> become open source which could never be upheld...

It would depend on the derivative nature of the work. "Linking" is not a 
programming thing here. The objective C case was two seperate binaries for
example
