Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315530AbSECBtG>; Thu, 2 May 2002 21:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315532AbSECBtF>; Thu, 2 May 2002 21:49:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37636 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315530AbSECBtF>; Thu, 2 May 2002 21:49:05 -0400
Subject: Re: Re[6]: Support of AMD 762?
To: ekuznetsov@divxnetworks.com
Date: Fri, 3 May 2002 03:08:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <581358328.20020502182546@divxnetworks.com> from "Eugene Kuznetsov" at May 02, 2002 06:25:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E173SUW-0005Qr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which writers guide you are referring to?
> I found this one on AMD web site:
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24462.pdf
> "AMD-762™ System Controller Software/BIOS Design Guide"
> But I don't see anything on-topic in it. It contains 5 occurrences of
> "APIC" and no occurrences of either "IRQ" or "MP".

Look at the IRQ routing logic description it provides. 

