Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290754AbSAYR4i>; Fri, 25 Jan 2002 12:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290758AbSAYR42>; Fri, 25 Jan 2002 12:56:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290754AbSAYR4P>; Fri, 25 Jan 2002 12:56:15 -0500
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 25 Jan 2002 18:08:34 +0000 (GMT)
Cc: Martin.Wilck@fujitsu-siemens.com (Martin Wilck),
        linux-kernel@vger.kernel.org (Linux Kernel mailing list),
        rgooch@atnf.csiro.au (Richard Gooch),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <Pine.LNX.4.33.0201241338030.15092-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 24, 2002 01:39:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UAmA-00038O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > intensive research did show up nothing. Also my first post on LK
> > received no "hey, that's old stuff" answer. So here I go.
> 
> There is a patch from Asit Mallik floating around, which I've applied in
> my tree. Most of us mere mortals can't test it yet, of course.

2.4 has a nice clean 2 line patch in to cover this or should have done
providing it didnt get lost in the merge.
