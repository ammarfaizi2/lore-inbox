Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281221AbRLBSvD>; Sun, 2 Dec 2001 13:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281210AbRLBSut>; Sun, 2 Dec 2001 13:50:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38674 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281221AbRLBSud>; Sun, 2 Dec 2001 13:50:33 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: oxymoron@waste.org (Oliver Xymoron)
Date: Sun, 2 Dec 2001 18:59:17 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.40.0112021206040.28065-100000@waste.org> from "Oliver Xymoron" at Dec 02, 2001 12:16:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Abpd-0004Bf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And it's practically obsolete itself, outside of the ARM directory. What

Thats just history. Doesn't mean it won't do the job. Probably when we get
to say 2.5.4 or so someone should do a build all as modules and anything
that doesn't build gets an obsolete tag until someone fixes it.

Anything not fixed for 2.6 will then be nicely labelled
