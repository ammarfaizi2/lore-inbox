Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNXJW>; Thu, 14 Dec 2000 18:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133089AbQLNXJM>; Thu, 14 Dec 2000 18:09:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1540 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129260AbQLNXIz>; Thu, 14 Dec 2000 18:08:55 -0500
Subject: Re: Is this a compromise and how?
To: F.vanMaarseveen@inter.NL.net (Frank van Maarseveen)
Date: Thu, 14 Dec 2000 22:40:38 +0000 (GMT)
Cc: brian@top.worldcontrol.com (Brian Litzinger), linux-kernel@vger.kernel.org
In-Reply-To: <20001214212211.A10157@iapetus.localdomain> from "Frank van Maarseveen" at Dec 14, 2000 09:22:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146h3H-000087-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm guessing that your ls was also hijacked.  You're using RedHat, so try
> > the rpm -V command
> Once hacked you can't trust anything. A malicious person might just
> install RPMs for example.

There is a proper way to do this. You boot the rescue CD, then do the rpm 
verify of each package with the rpm binary on the CD (static) agains the
package on the CD. 

> Re-install is the only option.

I would advise this however it is not 'only' but 'very good idea'

> Restore backups only after verifying that they do not re-install the

(popular one is roots .login)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
