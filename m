Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288996AbSBRXn6>; Mon, 18 Feb 2002 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSBRXnj>; Mon, 18 Feb 2002 18:43:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53001 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288969AbSBRXnd>; Mon, 18 Feb 2002 18:43:33 -0500
Subject: Re: jiffies rollover, uptime etc.
To: ahu@ds9a.nl (bert hubert)
Date: Mon, 18 Feb 2002 23:57:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020219002614.A27210@outpost.ds9a.nl> from "bert hubert" at Feb 19, 2002 12:26:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16cxfF-0007Dq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you consider it worth rebooting for? By the way, this is our second
> most important production server, I'm exceedingly pleased with the
> stability. We've abused it no end.

I would schedule maintenance for it at the point it wraps. Its not the most
tested code path in 2.2
