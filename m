Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310905AbSCHPQm>; Fri, 8 Mar 2002 10:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310906AbSCHPQW>; Fri, 8 Mar 2002 10:16:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25100 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310905AbSCHPQT>; Fri, 8 Mar 2002 10:16:19 -0500
Subject: Re: Linux kernel crashes repeatedly
To: Roland.Boden@activelink.de
Date: Fri, 8 Mar 2002 15:31:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF6648ADF3.2CD72017-ONC1256B76.00500C9A@activelink.de> from "Roland.Boden@activelink.de" at Mar 08, 2002 04:04:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jMLO-0006Up-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux version 2.4.4 (root@al-net-mun-00) (gcc version 2.95.3 20010315
> (SuSE)) #4 Wed Nov 7 20:07:27 MET 2001

Start by upgrading to a vaguely current kernel. Numerous masquerading and
other bugs have been fixed since 2.4.4. Notably the masq ones sound good
suspects
