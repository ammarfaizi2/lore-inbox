Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbRENPBe>; Mon, 14 May 2001 11:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbRENPBZ>; Mon, 14 May 2001 11:01:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17157 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262112AbRENPBJ>; Mon, 14 May 2001 11:01:09 -0400
Subject: Re: Minor numbers
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Mon, 14 May 2001 15:57:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), aqchen@us.ibm.com (Alex Q Chen),
        linux-kernel@vger.kernel.org
In-Reply-To: <200105141302.PAA14005@cave.bitwizard.nl> from "Rogier Wolff" at May 14, 2001 03:02:08 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zJmj-0000p3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 20:12 is more common
> 
> Which is major, which is minor?

20bit major

> I have one (private) driver that requires around 5000 minors.
> (currently through some 20 majors) (Currently only just over half of
> these are physically installed....)

Just use several. The split is a bit vague in modern OS's - because its
really now heirarchical in many of them - eg the solaris  controller, bus,
unit, lun, .. thing.

I guess it went the way of classed addressing

