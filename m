Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRDEB0d>; Wed, 4 Apr 2001 21:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132482AbRDEB0W>; Wed, 4 Apr 2001 21:26:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25361 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132042AbRDEB0A>; Wed, 4 Apr 2001 21:26:00 -0400
Subject: Re: ReiserFS? How reliable is it? Is this the future?
To: xuan--reiserfs@baldauf.org (Xuan Baldauf)
Date: Thu, 5 Apr 2001 02:13:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        nicholas@petreley.com (Nicholas Petreley),
        harri@synopsys.COM (Harald Dunkel), linux-kernel@vger.kernel.org
In-Reply-To: <3ACBC4F4.C177E40A@baldauf.org> from "Xuan Baldauf" at Apr 05, 2001 03:05:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kyLV-0003AB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a reiserfs security issue, but only of theoretical nature (Even i=
> f
> triggered, it won't harm you). But the reason for this bug is in NFS (v2,=

If the blocks contained my old /etc/shadow I'd be a bit upset.

> displacement instead of vertical displacement) is planned.
> 
> I can tell you more if you want.

I trust Chris to keep it in order. I've not yet had a broken patch from them
for -ac

