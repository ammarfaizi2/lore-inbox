Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbRFKQ3G>; Mon, 11 Jun 2001 12:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbRFKQ25>; Mon, 11 Jun 2001 12:28:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40722 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261861AbRFKQ2p>; Mon, 11 Jun 2001 12:28:45 -0400
Subject: Re: [CHECKER] 15 probable security holes in 2.4.5-ac8
To: jreuter@suse.de (Joerg Reuter)
Date: Mon, 11 Jun 2001 17:27:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010611155145.A12203@suse.de> from "Joerg Reuter" at Jun 11, 2001 03:51:45 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159UXI-0008QS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Granted. But I've no reports that anyone actually tried that,
> especially as the (unmodified) driver is only useful for packet radio
> purposes.
> 
> >Both fixed
> 
> How? ;-)

NR_IRQS is defined by each port. I used that. Its the blunt instrument approach
until you do it nicely 8)

