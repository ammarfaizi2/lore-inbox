Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRADR6S>; Thu, 4 Jan 2001 12:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbRADR6I>; Thu, 4 Jan 2001 12:58:08 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39439 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129406AbRADR5y>; Thu, 4 Jan 2001 12:57:54 -0500
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
To: david.lang@digitalinsight.com (David Lang)
Date: Thu, 4 Jan 2001 17:59:17 +0000 (GMT)
Cc: phillips@innominate.de (Daniel Phillips),
        helgehaf@idb.hist.no (Helge Hafting), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0101040942550.10387-100000@dlang.diginsite.com> from "David Lang" at Jan 04, 2001 09:43:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EEfY-00067i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for crying out loud, even windows tells the users they need to shutdown
> first and gripes at them if they pull the plug. what users are you trying
> to protect, ones to clueless to even run windows?

Clueless ?  Hardly. Every other appliance in the home you turn it off and it
goes off. You turn it on and it comes on. You get confused you turn it off and
on. Its the definitive model of how home appliances works and its how people
expect them to work.

In the embedded world you will regularly see adherence to that model in 
the specification. Firstly because the users do it, secondly because power
cuts ensure it happens anyway

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
