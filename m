Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSCSXyg>; Tue, 19 Mar 2002 18:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310913AbSCSXy0>; Tue, 19 Mar 2002 18:54:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47634 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310835AbSCSXyS>; Tue, 19 Mar 2002 18:54:18 -0500
Subject: Re: Bitkeeper licence issues
To: trini@kernel.crashing.org (Tom Rini)
Date: Wed, 20 Mar 2002 00:09:31 +0000 (GMT)
Cc: lm@work.bitmover.com (Larry McVoy), pavel@suse.cz (Pavel Machek),
        davej@suse.de (Dave Jones), linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020319233432.GS3762@opus.bloom.county> from "Tom Rini" at Mar 19, 2002 04:34:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nTfX-0000je-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I hate to jump in here (really I do) but 'a' probably happens alot.  All
> of the recommended locations are system directories.  As for 'b' and
> 'c', I think those are considered trivial things to do, since this would
> be a relativly easy thing to expliot (search some of the security list
> archives, this isn't quite as easy as the buffer overflow on x86
> problem, but still trivial).

'c' is a piece of cake. People wrote tools using directory notifiers that
do nothing but try and subvert every /tmp/ file as it appears. Neat and
novel [ab]use of it. 

This is however a kernel list. Security notifications ought to go to the
vendor and if they dont respond after a while to bugtraq where it would
be on topic and score you leetness bonuses

Alan
