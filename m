Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313276AbSDDRpR>; Thu, 4 Apr 2002 12:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313280AbSDDRpI>; Thu, 4 Apr 2002 12:45:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38158 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313276AbSDDRov>; Thu, 4 Apr 2002 12:44:51 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 4 Apr 2002 19:00:10 +0100 (BST)
Cc: mingo@redhat.com (Ingo Molnar),
        tigran@aivazian.fsnet.co.uk (Tigran Aivazian),
        alan@lxorguk.ukuu.org.uk (Alan Cox), kaos@ocs.com.au (Keith Owens),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        stelian.pop@fr.alcove.com (Stelian Pop),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20020404184405.C32431@dualathlon.random> from "Andrea Arcangeli" at Apr 04, 2002 06:44:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tBWs-0006Rh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> adding export symbol here and there it's the same thing you did in the
> redhat kernel and in your tux patches here:

Nothing to do with me. I suspect Ingo and DaveM both discussed it however.

> vmalloc_to_page. Now if you claim that that's not legal, then I claim
> all binary only drivers out there are completly illegal, because they

That is a possible situation. No lawyer I've talked to is prepared to give
a definitive answer on the question of whether it is a derivative work. In
the UK case it recently got even more complex because a judge ruled that
loading a program into memory is clearly an act of copying.

Alan
