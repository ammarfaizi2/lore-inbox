Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289636AbSAJTsK>; Thu, 10 Jan 2002 14:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289640AbSAJTr7>; Thu, 10 Jan 2002 14:47:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39948 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289636AbSAJTru>; Thu, 10 Jan 2002 14:47:50 -0500
Subject: Re: Bigggg Maxtor drives (fwd)
To: jfbeam@bluetronic.net (Ricky Beam)
Date: Thu, 10 Jan 2002 19:59:13 +0000 (GMT)
Cc: noth@noth.is.eleet.ca (Jim Crilly),
        linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <Pine.GSO.4.33.0201101408260.28783-100000@sweetums.bluetronic.net> from "Ricky Beam" at Jan 10, 2002 02:14:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OlM1-0005ND-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I'm sure many of his patches would be accepted if he sent them in the
> method prescribed by Linus (loudly and on multiple occasions.)  That is,

Loudly  - check. Believe me Andre is -LOUD-

> ONE patch to fix or support *ONE* thing. (Translation: minimize the amount
> of stuff you screw up with your patch.) The "megapatch" is deleted on sight.

I really don't think you can split that IDE stuff. I worked over some of
that with Andre for the -ac merge, and you just can't split it. Instead it
does the next best thing - you can run some code paths with the old or new
style
