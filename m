Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129167AbQJ0Pmv>; Fri, 27 Oct 2000 11:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbQJ0Pml>; Fri, 27 Oct 2000 11:42:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14602 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129167AbQJ0Pmc>; Fri, 27 Oct 2000 11:42:32 -0400
Date: Fri, 27 Oct 2000 17:42:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.2.18pre17 + VM-global -7 = `Negative d_count' oops
Message-ID: <20001027174219.A15798@athlon.random>
In-Reply-To: <39F4AB91.72F2C300@transmeta.com> <20001025050631.A6817@athlon.random> <14840.27617.448792.438567@chiark.greenend.org.uk> <20001027010539.B1282@athlon.random> <14841.25520.562811.894899@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14841.25520.562811.894899@chiark.greenend.org.uk>; from ijackson@chiark.greenend.org.uk on Fri, Oct 27, 2000 at 12:14:56PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 12:14:56PM +0100, Ian Jackson wrote:
> gcc version 2.95.2 20000220 (Debian GNU/Linux)

Please give a try to 2.95.2 19991024 (release) or egcs 1.1.2 or gcc 2.7.2.3. I
don't see anything strange in your .config.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
