Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312212AbSDDM2p>; Thu, 4 Apr 2002 07:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSDDM2Y>; Thu, 4 Apr 2002 07:28:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63243 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293680AbSDDM2W>; Thu, 4 Apr 2002 07:28:22 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Thu, 4 Apr 2002 12:54:06 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        andrea@suse.de (Andrea Arcangeli),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041041530.1475-100000@einstein.homenet> from "Tigran Aivazian" at Apr 04, 2002 11:22:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16t5oc-0005kr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There should be no "licensing implications" but simply the (documented)
> fact that if a proprietary module writer is stupid enough to make a
> MODULE_SYMBOLS_INTERNAL claim his module will break far more often both
> with respect to existence _and_ semantics/implemention of those entries

Using any internals of the Linux kernel has licensing implications. 

> exported only "internally". But that is their own problem -- we should
> neither help them nor prevent them from doing their work and earning their

So why are you trying to put me out of business by allowing people to use
my code in ways the GPL doesn't permit. That cuts both ways.
