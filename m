Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277497AbRJERAo>; Fri, 5 Oct 2001 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277495AbRJERAY>; Fri, 5 Oct 2001 13:00:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59143 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277486AbRJERAR>; Fri, 5 Oct 2001 13:00:17 -0400
Subject: Re: 3ware discontinuing the Escalade Series
To: rugolsky@ead.dsa.com
Date: Fri, 5 Oct 2001 18:05:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com, jgiglio@smythco.com
In-Reply-To: <20011005125259.B1221@ead45> from "rugolsky@ead.dsa.com" at Oct 05, 2001 12:52:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pYQ1-00071M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really like my 7800.  At this point I guess I'm going to convert from
> hard to soft RAID, on the theory that (unfixed) bugs in the firmware are less
> likely to botch JBOD. 

Except for RAID5 the softraid is also likely to outperform a hardware raid
controller. With RAID5 its a CPU usage tradeoff
