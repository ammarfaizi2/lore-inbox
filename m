Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSDCVLL>; Wed, 3 Apr 2002 16:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311642AbSDCVLB>; Wed, 3 Apr 2002 16:11:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25350 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293276AbSDCVKy>; Wed, 3 Apr 2002 16:10:54 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Wed, 3 Apr 2002 22:25:52 +0100 (BST)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204032203520.1612-100000@einstein.homenet> from "Tigran Aivazian" at Apr 03, 2002 10:05:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ssGO-0004YM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, so that would cover the 2.5.x (and future stable) kernels. Does
> Marcelo also agree that it should be the case in the 2.4.x kernel?

Thats a Keith Owens question - will it break current modutils ? I think
modutils compatibility for 2.4 must be sacrosanct
