Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292866AbSB0U6s>; Wed, 27 Feb 2002 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292945AbSB0U61>; Wed, 27 Feb 2002 15:58:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34064 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292944AbSB0U6B>; Wed, 27 Feb 2002 15:58:01 -0500
Subject: Re: kernel 2.4.18 and RH 7.2
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 27 Feb 2002 21:12:11 +0000 (GMT)
Cc: joeja@mindspring.com (Joe), linux-kernel@vger.kernel.org
In-Reply-To: <20020227202622.A25404@flint.arm.linux.org.uk> from "Russell King" at Feb 27, 2002 08:26:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gBMx-0005rt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> iptables 1.2.4 was rebuild for the 2.4.17 because it stopped working at
> that point.  I hope it isn't requirement to rebuild iptables against each
> stable kernel release.

Its not a requirement for 1.2.4 and 2.4.18 either - what happened was that
some people (Red Hat notably) turned all the paranoid debugging stuff on
and that is what spews the warnings.

