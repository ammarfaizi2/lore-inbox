Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbRBZR73>; Mon, 26 Feb 2001 12:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129452AbRBZR7T>; Mon, 26 Feb 2001 12:59:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4360 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129440AbRBZR7G>; Mon, 26 Feb 2001 12:59:06 -0500
Subject: Re: Posible bug in gcc
To: jakub@redhat.com
Date: Mon, 26 Feb 2001 18:02:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dllorens@lsi.uji.es (David),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010226123309.A16592@devserv.devel.redhat.com> from "Jakub Jelinek" at Feb 26, 2001 12:33:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XRyY-0001gE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well gcc-bugs would be the better place to send it but this is a known problem
> > fixed in CVS gcc 2.95.3, CVS gcc 3.0 branch and gcc 2.96 (unofficial, Red Hat)
> 
> I'm not sure if it is known, at least not known to me, but definitely not
> fixed in any of gcc 2.95.2, CVS gcc 3.0 branch, CVS gcc 3.1 head, gcc 2.96-RH.

Sorry my error for assuming it was the exsting known strength reduce bug

