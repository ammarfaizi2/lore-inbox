Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286227AbSAAKDZ>; Tue, 1 Jan 2002 05:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286230AbSAAKDQ>; Tue, 1 Jan 2002 05:03:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61202 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286227AbSAAKDE>; Tue, 1 Jan 2002 05:03:04 -0500
Subject: Re: Hot swap support in linux?
To: raghavendra.koushik@wipro.com (Raghavendra Koushik)
Date: Tue, 1 Jan 2002 10:13:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <008001c1927d$0f175840$5408720a@M3NOR67026> from "Raghavendra Koushik" at Jan 01, 2002 10:00:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LLva-0008AG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the current linux kernel support hot swap feature for network interface
> cards(NICs). I would be glad if any of you can provide me some pointers or
> documentation regards the same...

If your hardware supports it - yes. You'll need something like the compaq
hotswap pci backplanes or of course simply use cardbus
