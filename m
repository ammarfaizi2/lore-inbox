Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310406AbSCBSQv>; Sat, 2 Mar 2002 13:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310409AbSCBSQl>; Sat, 2 Mar 2002 13:16:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310406AbSCBSQ2>; Sat, 2 Mar 2002 13:16:28 -0500
Subject: Re: Linux 2.4.19pre2-ac1
To: skidley@crrstv.net (skidley)
Date: Sat, 2 Mar 2002 18:30:17 +0000 (GMT)
Cc: mfedyk@matchmail.com (Mike Fedyk), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0203012351360.1612-100000@localhost.localdomain> from "skidley" at Mar 01, 2002 11:56:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hEGv-0007y2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was wondering about the new Machine Check Exception Option added with
> this patch. where can I get info(if there is any) on using it, re the boot option to use the Mb's it supports and any userland stuff if any.

Just say yes, its a stupid idea making it an option and there is basically
no reason to ever say no.
