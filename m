Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314231AbSD0PES>; Sat, 27 Apr 2002 11:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314238AbSD0PER>; Sat, 27 Apr 2002 11:04:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314231AbSD0PEQ>; Sat, 27 Apr 2002 11:04:16 -0400
Subject: Re: [PATCH} SMBIOS support
To: minyard@acm.org (Corey Minyard)
Date: Sat, 27 Apr 2002 16:22:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CCA1462.9010405@acm.org> from "Corey Minyard" at Apr 26, 2002 10:00:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171U1r-0008Pk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch adds support for reading the SMBIOS table (which 
> contains system management information).  It's required for IPMI and has 
> useful information in it.  But anyway, since I did the work, I thought I 
> would post this.

We already have DMI table parsing code in 2.4 and 2.5. Its been there for
a very long time.  Please use that instead


Alan
