Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130342AbRBZRMe>; Mon, 26 Feb 2001 12:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130343AbRBZRMO>; Mon, 26 Feb 2001 12:12:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51207 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130342AbRBZRMG>; Mon, 26 Feb 2001 12:12:06 -0500
Subject: Re: Posible bug in gcc
To: dllorens@lsi.uji.es (David)
Date: Mon, 26 Feb 2001 17:15:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A9A8489.224CF54C@inf.uji.es> from "David" at Feb 26, 2001 05:30:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XRFC-0001ay-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I heve found a bug in gcc. I have tried both egcs 1.1.2 (gcc
> 2.91.66) and gcc 2.95.2 versions.
> 
> I am attaching you a simplified test program ('bug.c', a really simple
> program).

Well gcc-bugs would be the better place to send it but this is a known problem
fixed in CVS gcc 2.95.3, CVS gcc 3.0 branch and gcc 2.96 (unofficial, Red Hat)

