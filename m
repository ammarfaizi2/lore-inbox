Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284118AbRLKWT3>; Tue, 11 Dec 2001 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284124AbRLKWTT>; Tue, 11 Dec 2001 17:19:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27142 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284118AbRLKWTL>; Tue, 11 Dec 2001 17:19:11 -0500
Subject: Re: aacraid success with 2.4.17-pre8. Intentional?
To: matt@bodgit-n-scarper.com (Matt)
Date: Tue, 11 Dec 2001 22:28:40 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011211150717.A20308@mould.bodgit-n-scarper.com> from "Matt" at Dec 11, 2001 03:07:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DvOC-0006wF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've just tried the latest 2.4.17-pre8 kernel, and it works, in that
> it gets passed the fsck'ing. I couldn't see anything in the changelog that
> screamed "Fix fsck hang with aacraid", so I was wondering if my working
> setup is intentional or not? I haven't followed the development of this
> driver too closely, I just had the card and downloaded the latest "stable"
> release and went from there...

The later fixes I applied (and Matt Domsch's fixes too) don't really do
anything that would explain this.

Alan
