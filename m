Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271693AbRH0Kl1>; Mon, 27 Aug 2001 06:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271695AbRH0KlR>; Mon, 27 Aug 2001 06:41:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1541 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271693AbRH0KlD>; Mon, 27 Aug 2001 06:41:03 -0400
Subject: Re: "Machine Exception Check.... " with the last kernel?
To: robert.casanova@grifols.com (Casanova Robert)
Date: Mon, 27 Aug 2001 11:44:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010827115750.00b4a790@pop3.grifols.com> from "Casanova Robert" at Aug 27, 2001 11:57:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bJse-0003gG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> someone know how to resolver the
> "Machine Exception Check.... " with the last kernel?

Machine Check Exception is a trap the processor takes when it finds itself
internally inconsistent. Check the cooling, voltages and clock speeds are
right. Its your CPU telling you it noticed things didnt seem happy.

Alan
