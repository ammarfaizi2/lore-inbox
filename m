Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbRE1WYq>; Mon, 28 May 2001 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbRE1WYg>; Mon, 28 May 2001 18:24:36 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263185AbRE1WY2>; Mon, 28 May 2001 18:24:28 -0400
Subject: Re: [patch]: ide dma timeout retry in pio
To: lm@bitmover.com (Larry McVoy)
Date: Mon, 28 May 2001 23:20:35 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        hahn@coffee.psychology.mcmaster.ca (Mark Hahn),
        axboe@suse.de (Jens Axboe), andre@linux-ide.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010528231809.A29504@work.bitmover.com> from "Larry McVoy" at May 28, 2001 11:18:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154VNL-0003cl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For what it is worth, in the recent postings I made about this topic, you
> suggested that it was bad cabling, I swapped the cabling, same problem.
> I swapped the mother board from Abit K7T to ASUS A7V and all cables worked
> fine.
> 
> I really think there is a software problem in there with certain chipsets,
> those from VIA seem to be problematic.

Well given the catalogue of VIA chipset problems popping up on news sites right
now that would not suprise me. Also the non -ac tree has a very out of date
VIA ide driver although I don't think that impacts this case.

Alan

