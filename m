Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbQLRWU6>; Mon, 18 Dec 2000 17:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbQLRWUr>; Mon, 18 Dec 2000 17:20:47 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4103 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129747AbQLRWUg>; Mon, 18 Dec 2000 17:20:36 -0500
Subject: Re: Linux 2.4.0test13pre3ac1
To: jani@virtualro.ic.ro (Jani Monoses)
Date: Mon, 18 Dec 2000 21:52:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012182211040.15640-100000@virtualro.ic.ro> from "Jani Monoses" at Dec 18, 2000 10:17:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1488CX-0006GU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 18 Dec 2000, Alan Cox wrote:
> > o	Teach kernel-doc about const			(Jani Monoses)
> 
> Tim Waugh pointed out this wasn't good as 'const' is part of the function
> signature and he now has a better patch.
> For these I've sent Tim more cleaned up patches as I thought nobody picked
> them up from the list.Looks like I was wrong ;-)

Thanks for the info. I'll pick up the changes when Tim sends them on

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
