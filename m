Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbQKKRJj>; Sat, 11 Nov 2000 12:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbQKKRJ3>; Sat, 11 Nov 2000 12:09:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31238 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131625AbQKKRJU>; Sat, 11 Nov 2000 12:09:20 -0500
Date: Sat, 11 Nov 2000 11:05:16 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001111110516.B9464@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.3.95.1001110142537.5403A-100000@chaos.analogic.com>, <3A0C4D6B.B4FF664C@timpanogas.org> <8ujha2$1ou$1@forge.tanstaafl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <8ujha2$1ou$1@forge.tanstaafl.de>; from hps@tanstaafl.de on Sat, Nov 11, 2000 at 01:24:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 01:24:18PM +0000, Henning P. Schmiedehausen wrote:
> jmerkey@timpanogas.org (Jeff V. Merkey) writes:
> 
> >I did Dick.  The config is fine.  The daemon is also fine and running. 
> >What's really weird is that even if I do a "sendmail -v -q" command
> >(which should force the queue to flush) it still doesn't. 
> 
> O Timeout.ident=0s
> O Timeout.initial=30s (these are the ninieties / 21st century)
> 
> Get someone that really has an idea about sendmail. 
> 
> 	Regards
> 		Henning

Ha ha.  It's fixed.

Jeff

> -- 
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
> 
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20   
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
