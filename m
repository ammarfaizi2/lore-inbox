Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283374AbRLDT6d>; Tue, 4 Dec 2001 14:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283368AbRLDT5X>; Tue, 4 Dec 2001 14:57:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283349AbRLDT45>; Tue, 4 Dec 2001 14:56:57 -0500
Subject: Re: nfs: task can't get a request slot
To: kristian.peters@korseby.net (Kristian Peters)
Date: Tue, 4 Dec 2001 20:05:20 +0000 (GMT)
Cc: matt@theBachChoir.org.uk (Matt Bernstein), nbecker@fred.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C0D20E2.9040801@korseby.net> from "Kristian Peters" at Dec 04, 2001 08:15:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BLoe-0003H4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's right. But in meantime my load increases to 150.. (I had that 
> yesterday...) Isn't there a way to force it shutdown even if there's no response 
> ? I thought that would be possible by mounting it soft ?

The load isnt a problem, its all I/O wait not CPU
