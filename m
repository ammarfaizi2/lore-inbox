Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284519AbRLRShn>; Tue, 18 Dec 2001 13:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284497AbRLRShg>; Tue, 18 Dec 2001 13:37:36 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:19950 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284491AbRLRSgg>; Tue, 18 Dec 2001 13:36:36 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181551.fBIFpZk16458@pinkpanther.swansea.linux.org.uk>
Subject: Re: CONFIG_SOUND_DMAP: Confusing Configure.help entry.
To: nkbj@image.dk (Niels Kristian Bech Jensen)
Date: Tue, 18 Dec 2001 15:51:35 +0000 (GMT)
Cc: crimsun@email.unc.edu (Daniel T. Chen),
        linux-kernel@vger.kernel.org (Linux kernel developer's mailing list)
In-Reply-To: <Pine.LNX.4.33.0112160358590.4516-100000@hafnium.nkbj.dk> from "Niels Kristian Bech Jensen" at Dec 16, 2001 04:00:31 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Say Y unless you have less than 16MB of RAM or a PCI sound card."
> 
> That would also remove the contradiction.

The rule is if > 16Mb RAM set dmap. PCI doesnt matter. 
