Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290722AbSA3XDw>; Wed, 30 Jan 2002 18:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290735AbSA3XCV>; Wed, 30 Jan 2002 18:02:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41479 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290728AbSA3XBg>; Wed, 30 Jan 2002 18:01:36 -0500
Subject: Re: Athlon Optimization Problem
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 30 Jan 2002 23:10:44 +0000 (GMT)
Cc: calin@ajvar.org (Calin A. Culianu), alan@lxorguk.ukuu.org.uk (Alan Cox),
        hassani@its.caltech.edu (Steven Hassani), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020130170637.5584C-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Jan 30, 2002 05:12:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16W3sK-0000LF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> put in after much discussion, and I believe there were no documented cases
> of a system being hurt by it. I could easily have missed something,
> obviously, but "my system doesn't need it" isn't a good reason to pull
> code.

For the 0x55 case I have no negatives. For the 0x95 case I have several
disk corruption cases from 2.2.21pre
