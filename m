Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRDUANB>; Fri, 20 Apr 2001 20:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRDUAMv>; Fri, 20 Apr 2001 20:12:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36873 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132281AbRDUAMn>; Fri, 20 Apr 2001 20:12:43 -0400
Subject: Re: Athlon problem report summary
To: lkml@sigkill.net (Disconnect)
Date: Sat, 21 Apr 2001 01:14:02 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010420195253.A20176@sigkill.net> from "Disconnect" at Apr 20, 2001 07:52:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ql2L-0002YR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Addendum to 1. So far everyone (at least on LKML) who has had the
> crash-immediatly-do-not-pass-go issues has been using an iwill kk266 (or
> kk266r, IIRC) mobo.

Not quite all. Many have but I have other reports.

> Have we gotten any fix, other than not using K7 optimizations?

As far as I can tell its hardware problems. The fact not a single AMD chipset
user sees it makes me very suspicious indeed.

Alan

