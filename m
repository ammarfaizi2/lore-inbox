Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRDCQzA>; Tue, 3 Apr 2001 12:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRDCQyu>; Tue, 3 Apr 2001 12:54:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22791 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131669AbRDCQyn>; Tue, 3 Apr 2001 12:54:43 -0400
Subject: Re: Larger dev_t
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Tue, 3 Apr 2001 17:54:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        Andries.Brouwer@cwi.nl, torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <200104031605.f33G5D604937@mobilix.atnf.CSIRO.AU> from "Richard Gooch" at Apr 03, 2001 09:05:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kU4P-0008Q3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, a large number of people run devfs on small to large systems,
> and these "races" aren't causing problems. People tell me it's quite

They dont have users actively trying to exploit them. I don't consider it a 
big problem for development trees though. devfs has a maintainer at least

Alan 

