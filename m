Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289611AbSAOToU>; Tue, 15 Jan 2002 14:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289610AbSAOToA>; Tue, 15 Jan 2002 14:44:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30212 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289608AbSAOTnv>; Tue, 15 Jan 2002 14:43:51 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
To: root@chaos.analogic.com
Date: Tue, 15 Jan 2002 19:55:22 +0000 (GMT)
Cc: marco@esi.it (Marco Colombo),
        Thomas.Duffy.99@alumni.brown.edu (Thomas Duffy),
        linux-kernel@vger.kernel.org (Linux Mailing List)
In-Reply-To: <Pine.LNX.3.95.1020115133220.818B-100000@chaos.analogic.com> from "Richard B. Johnson" at Jan 15, 2002 01:52:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QZg2-000616-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really???  Have you ever tried this? RedHat provides a directory
> of random patches that won't patch regardless of the order in
> which you attempt patches (based upon date-stamps on patches or
> date-stamps on files). It's like somebody just copied in some
> junk, thinking nobody would ever bother.

They apply nicely and the spec file defines which to apply and when. The
srpm and rpm are generated together.

I was wondering who would actually need Aunt Tillie's autoconfigurator, now
I know
