Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291321AbSBSL6j>; Tue, 19 Feb 2002 06:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291309AbSBSL6Y>; Tue, 19 Feb 2002 06:58:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42765 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291321AbSBSL6E>; Tue, 19 Feb 2002 06:58:04 -0500
Subject: Re: 2.4.18-pre9-ac4 filesystem corruption
To: kristian.peters@korseby.net (Kristian)
Date: Tue, 19 Feb 2002 12:12:14 +0000 (GMT)
Cc: michal@harddata.com (Michal Jaegermann), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20020219125211.10f80f4e.kristian.peters@korseby.net> from "Kristian" at Feb 19, 2002 12:52:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d982-0000LP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen filesystem corruption using -ac4 with ext2 although I'm not using
> a SIS chipset. So I really recommend using not this patch.

The SiS patch is only changing anything if the SiS vode is in use.

Precisely what chipset, what IDE, what ide cable (40/80 pin) and drives
do you have. What hdparm commands are you using if any ?

Alan
