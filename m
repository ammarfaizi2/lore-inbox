Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSCXQgj>; Sun, 24 Mar 2002 11:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310214AbSCXQga>; Sun, 24 Mar 2002 11:36:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18447 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310190AbSCXQgO>; Sun, 24 Mar 2002 11:36:14 -0500
Subject: Re: Bug Report (paging request)
To: gcckain@comcast.net (Mike Farrell)
Date: Sun, 24 Mar 2002 16:52:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0GTH00H0EF0QUJ@mtaout03.icomcast.net> from "Mike Farrell" at Mar 24, 2002 09:28:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pBEa-0006ft-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using "Linux 2.4.7 #7 SMP Wed Feb 13 15:20:25 EST 2002 i686"
> and I have had NO other problems with this kernel until now.  I have recently 
> added 256 mb of ram to my system but I don't think that should cause a 
> problem since the system runs it well.

You added 256Mb of RAM then it started crashing. I'd suggest you try without
the extra RAM again, and also check with memtest86
