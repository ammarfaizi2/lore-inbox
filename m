Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131190AbRBWScd>; Fri, 23 Feb 2001 13:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRBWScV>; Fri, 23 Feb 2001 13:32:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51724 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131190AbRBWScP>; Fri, 23 Feb 2001 13:32:15 -0500
Subject: Re: TESTERS PLEASE - improvements to knfsd for 2.4.2
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Fri, 23 Feb 2001 18:35:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010223185349.G7589@emma1.emma.line.org> from "Matthias Andree" at Feb 23, 2001 06:53:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14WN3n-0006pk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oh, please not again a stable kernel series with NFS problems, we're
> > locked in for ages. 2.2 was bad enough up to 2.2.18. We have ReiserFS
> > in 2.4.1 (and not in 2.4.0), could we _please_ get NFS-exportable
> > ReiserFS in 2.4.4 or 2.4.5?
> 
> 2.2.18 is still broken, won't play NFSv3 games with FreeBSD clients.
> Neil has posted a patch here which fixes this.

2.2.19pre has all the changes Neil has sent me. One reason I wanted to avoid
NFS changes was that they would do somthings we didnt want. And they did 
although nothing too bad.

The 2.2.19 schedule btw is about another week
