Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbQLKNe7>; Mon, 11 Dec 2000 08:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbQLKNet>; Mon, 11 Dec 2000 08:34:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130425AbQLKNeg>; Mon, 11 Dec 2000 08:34:36 -0500
Subject: Re: inline docs question
To: jani@virtualro.ic.ro (Jani Monoses)
Date: Mon, 11 Dec 2000 13:06:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012111212240.943-100000@virtualro.ic.ro> from "Jani Monoses" at Dec 11, 2000 12:13:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145Sev-0007tD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	which functions DON'T need inline documentation in the kernel?

A good guide initially is probably 'document those that are exported via
EXPORT_SYM() only'


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
