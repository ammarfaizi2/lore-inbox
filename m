Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272137AbRIRPmX>; Tue, 18 Sep 2001 11:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272270AbRIRPmI>; Tue, 18 Sep 2001 11:42:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48134 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272137AbRIRPlj>; Tue, 18 Sep 2001 11:41:39 -0400
Subject: Re: Deadlock on the mm->mmap_sem
To: dhowells@redhat.com (David Howells)
Date: Tue, 18 Sep 2001 16:46:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        manfred@colorfullife.com (Manfred Spraul),
        andrea@suse.de (Andrea Arcangeli),
        torvalds@transmeta.com (Linus Torvalds), dhowells@redhat.com,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <6460.1000826771@warthog.cambridge.redhat.com> from "David Howells" at Sep 18, 2001 04:26:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jN4V-00018c-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you want codd for this its in the older -ac tree. Linus decided it wasnt
> > justified so it went out
> 
> Arjan said there was such a beast in the -ac stuff, but I guess this explains
> why I couldn't find it... Do you have any idea which -ac's?

It went in with the threaded core dump patch
