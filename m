Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286334AbRLJRmh>; Mon, 10 Dec 2001 12:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286332AbRLJRm1>; Mon, 10 Dec 2001 12:42:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286330AbRLJRmS>; Mon, 10 Dec 2001 12:42:18 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 17:51:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112101230440.17940-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 12:38:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DUaV-0002mw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but agpgart will not let more then one driver use it. So it will be
> _either_ 3d or video capture with switching upon Xserver restart. Sucks !

That sounds like agpgart needs fixing. Its going to be easier than hacking
the vm code
