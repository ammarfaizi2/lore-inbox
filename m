Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131645AbQLNVBF>; Thu, 14 Dec 2000 16:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132381AbQLNVA4>; Thu, 14 Dec 2000 16:00:56 -0500
Received: from hees.nijmegen.inter.nl.net ([193.67.237.8]:21895 "EHLO
	hees.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S131645AbQLNVAl>; Thu, 14 Dec 2000 16:00:41 -0500
Date: Thu, 14 Dec 2000 21:22:11 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Brian Litzinger <brian@top.worldcontrol.com>, linux-kernel@vger.kernel.org
Subject: Re: Is this a compromise and how?
Message-ID: <20001214212211.A10157@iapetus.localdomain>
In-Reply-To: <20001214005345.A3732@top.worldcontrol.com> <20001214005826.H12544@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20001214005826.H12544@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Thu, Dec 14, 2000 at 12:58:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2000 at 12:58:26AM -0800, Matthew Dharm wrote:
> 
> I doubt that.... from this description, you've been hacked.  Even if your
> /etc/inetd.conf is in good shape, it looks like someone got in.
> 
> I'm guessing that your ls was also hijacked.  You're using RedHat, so try
> the rpm -V command
Once hacked you can't trust anything. A malicious person might just
install RPMs for example.

Re-install is the only option.

Restore backups only after verifying that they do not re-install the
backdoors as well. This is where your current hacked system may be
useful. Something like the coroners toolkit (?) written by Wietse Venema
(and others?) might help you determining at what date your system has
been hacked. Don't be suprised if you find multiple break-ins accumulated
over the years.

If you have (had) a network: attached systems may have been compromised
as well.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
