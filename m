Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312384AbSDCTaF>; Wed, 3 Apr 2002 14:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSDCTaB>; Wed, 3 Apr 2002 14:30:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37381 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312385AbSDCT31>; Wed, 3 Apr 2002 14:29:27 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 3 Apr 2002 20:38:20 +0100 (BST)
Cc: tigran@aivazian.fsnet.co.uk (Tigran Aivazian),
        alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204031106420.3004-100000@penguin.transmeta.com> from "Linus Torvalds" at Apr 03, 2002 11:10:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16sqaK-0004MO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that the code was back-ported from 2.5.x and that the _GPL still 
> is there too is just a mistake, partly because I've not gotten any updates 
> from Ingo..

So Linus is allowed to arbitarily export other peoples contributions ? I
think we need to clear this one up and understand what people think the
actual rules are around here. As I understand it the original code was
a) extracted from bttv and is code which I and DaveM partly wrote
b) was submitted by Gerd who did the extra work and kept it as _GPL when he 
   first exported it. (in 2.4 its relevant to expose it as we have the V4L1
   not V4L2 interface)

Nobody seems to have remembered to ask permission around here

Alan
