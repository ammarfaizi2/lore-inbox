Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277262AbRJDWuL>; Thu, 4 Oct 2001 18:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277261AbRJDWuC>; Thu, 4 Oct 2001 18:50:02 -0400
Received: from quechua.inka.de ([212.227.14.2]:33854 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S277259AbRJDWtt>;
	Thu, 4 Oct 2001 18:49:49 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
In-Reply-To: <Pine.LNX.4.10.10110031648250.20425-100000@coffee.psychology.mcmaster.ca>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15pHJT-00041q-00@calista.inka.de>
Date: Fri, 05 Oct 2001 00:49:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10110031648250.20425-100000@coffee.psychology.mcmaster.ca> you wrote:
> for a current Maxtor 60G 5400 RPM UDMA100 disk, 2.4.10, ext2,
> I just measured: 7 MBps with -W0, vs 27 MB/s with -W1.

how much data do you have written to get those numbers? The drive cache is
is most often so small it only can cache a few blocks.

Greetings
Bernd
