Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132564AbRDKMc1>; Wed, 11 Apr 2001 08:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132565AbRDKMcS>; Wed, 11 Apr 2001 08:32:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132564AbRDKMcE>; Wed, 11 Apr 2001 08:32:04 -0400
Subject: Re: [PATCH] i386 rw_semaphores fix
To: ak@suse.de (Andi Kleen)
Date: Wed, 11 Apr 2001 13:32:29 +0100 (BST)
Cc: tao@acc.umu.se (David Weinehall), ak@suse.de (Andi Kleen),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        dhowells@cambridge.redhat.com (David Howells),
        andrewm@uow.edu.au (Andrew Morton), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010411022028.A28874@gruyere.muc.suse.de> from "Andi Kleen" at Apr 11, 2001 02:20:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nJnU-0006XZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My reasoning is that who uses a 386 is not interested in speed, so a little
> bit more slowness is not that bad.
> 
> You realize that the alternative for distributions is to drop 386 support
> completely?

Rubbish. Mandrake and Red Hat have been shipping multiple kernel images,
multiple gzips and multiple glibc's for a very long time. It is quite simply
not a problem.

