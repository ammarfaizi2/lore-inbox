Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292296AbSBPAgb>; Fri, 15 Feb 2002 19:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292297AbSBPAgO>; Fri, 15 Feb 2002 19:36:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44818 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292296AbSBPAgJ>; Fri, 15 Feb 2002 19:36:09 -0500
Subject: Re: Disgusted with kbuild developers
To: dlang@diginsite.com (David Lang)
Date: Sat, 16 Feb 2002 00:49:56 +0000 (GMT)
Cc: lm@bitmover.com (Larry McVoy), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202151549360.2991-100000@dlang.diginsite.com> from "David Lang" at Feb 15, 2002 03:51:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bt36-0004nn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 'press' reports was that it was the CML1 guys who said they wanted to
> throw it out and start from scratch. I don't know what role Eric had in
> the discussion, but it sure didn't sound like it was him alone prompting
> the change.

I was at the summit but I guess I missed any real discussion on it, other
than the out of meeting sequence with Linus basically yelling at Eric
over some CML2 stuff.

I still hold the opinion the CML1 declarations are sufficient, and that
mconfig is more than enough to do what we need, possibly coupled with
some automatic rule validation stuff.

Michael Chastain fixed the nasty parsing mess in 1998
