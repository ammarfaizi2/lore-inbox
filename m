Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSA2XPr>; Tue, 29 Jan 2002 18:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSA2XOW>; Tue, 29 Jan 2002 18:14:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64009 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286723AbSA2XN5>; Tue, 29 Jan 2002 18:13:57 -0500
Subject: Re: Athlon Optimization Problem
To: calin@ajvar.org (Calin A. Culianu)
Date: Tue, 29 Jan 2002 23:26:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        hassani@its.caltech.edu (Steven Hassani), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0201291604340.10200-100000@rtlab.med.cornell.edu> from "Calin A. Culianu" at Jan 29, 2002 04:05:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VheG-0005UP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really?  VIA's own stuff doesn't touch 0x95?  Hmm.  Well is there ever a
> case where touching 0x95 solved ANYTHING?
> 
> What do you think?  Should I change the patch to not touch 0x95?

I don't know. I want to take just that bit out of the next 2.2.21pre and
see what is reported
