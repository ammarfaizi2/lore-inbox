Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133098AbRDRMVy>; Wed, 18 Apr 2001 08:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133104AbRDRMVo>; Wed, 18 Apr 2001 08:21:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37125 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133098AbRDRMVY>; Wed, 18 Apr 2001 08:21:24 -0400
Subject: Re: I can eject a mounted CD
To: pochini@shiny.it (Giuliano Pochini)
Date: Wed, 18 Apr 2001 13:23:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lna@bigfoot.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.010418092543.pochini@shiny.it> from "Giuliano Pochini" at Apr 18, 2001 09:25:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pqzO-0004bp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > rpm -e magicdev
> 
> Magicdev is not installed.
> Ok, I'm the only one with this problem, I'll manage to find the bug by myself.

vmware and one or two other apps I've also seen do this. WHen you unlock the
cdrom door as root you can unlock it even if a file system is mounted
