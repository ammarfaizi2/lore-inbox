Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284191AbRLKWxj>; Tue, 11 Dec 2001 17:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284186AbRLKWxb>; Tue, 11 Dec 2001 17:53:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284178AbRLKWxS>; Tue, 11 Dec 2001 17:53:18 -0500
Subject: Re: aacraid success with 2.4.17-pre8. Intentional?
To: matt@bodgit-n-scarper.com (Matt)
Date: Tue, 11 Dec 2001 23:02:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011211224104.B256@butterlicious.bodgit-n-scarper.com> from "Matt" at Dec 11, 2001 10:41:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DvvA-0007EN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there anything I can do to help? I can provide the kernel config if that
> would be useful, (I can't get at it until tomorrow morning), which is the same
> one I used on all three kernel builds. The box isn't in production use,
> (funny, that), so I can run some tests if needs be.

I guess beat it up hard with the 2.4.17pre tree including running graphical
stuff and see what happens. It could be your other problem was aacraid
triggering another bug thats been fixed.
