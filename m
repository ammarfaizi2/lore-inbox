Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSCUNUI>; Thu, 21 Mar 2002 08:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311721AbSCUNT6>; Thu, 21 Mar 2002 08:19:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14088 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311641AbSCUNTq>; Thu, 21 Mar 2002 08:19:46 -0500
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
To: nahshon@actcom.co.il
Date: Thu, 21 Mar 2002 13:34:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hch@infradead.org (Christoph Hellwig),
        Martin.Bligh@us.ibm.com (Martin J. Bligh),
        andrea@suse.de (Andrea Arcangeli), hugh@veritas.com (Hugh Dickins),
        riel@conectiva.com.br (Rik van Riel),
        dmccr@us.ibm.com (Dave McCracken),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200203210421.g2L4Lwx22756@lmail.actcom.co.il> from "Itai Nahshon" at Mar 21, 2002 06:21:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o2i1-0005Bu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Truely I thought that putting everything in "current" in Linux was
> more of a design decision and not something that's derived from
> the '86 architecture.

It is - I said Linux8086 not Linux 80386.

Alan

