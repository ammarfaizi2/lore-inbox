Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSAMB2N>; Sat, 12 Jan 2002 20:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSAMB2A>; Sat, 12 Jan 2002 20:28:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20996 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286311AbSAMB1o>; Sat, 12 Jan 2002 20:27:44 -0500
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
To: andreas@xss.co.at (Andreas Haumer)
Date: Sun, 13 Jan 2002 01:39:23 +0000 (GMT)
Cc: bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org
In-Reply-To: <3C40C066.CF147D02@xss.co.at> from "Andreas Haumer" at Jan 13, 2002 12:01:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZcJ-0003iH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyone working on backporting it to 2.2.21? 
> Alan?

2.2 does not support VIA SMP, its probably not a good kernel to choose for
the buggy VIA chipsets either. 
