Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278572AbRJ3XDy>; Tue, 30 Oct 2001 18:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278658AbRJ3XDo>; Tue, 30 Oct 2001 18:03:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55048 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278572AbRJ3XDZ>; Tue, 30 Oct 2001 18:03:25 -0500
Subject: Re: Module Licensing?
To: ttabi@interactivesi.com (Timur Tabi)
Date: Tue, 30 Oct 2001 23:10:16 +0000 (GMT)
Cc: hairballmt@mcn.net (TimO), linux-kernel@vger.kernel.org
In-Reply-To: <3BDEE301.3000008@interactivesi.com> from "Timur Tabi" at Oct 30, 2001 11:27:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yi1Q-0001ad-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> files and closed-source .o files.  That is, it's "mixed source" - part of the 
> driver is open-source and part is closed-source.  What happens if the 
> open-source version of the driver is the only code that uses GPL-only symbols. 
>   How is that handled?

Well then the open source bit would be GPL which would mean you can;t link
it with the binary bit.

Alan
