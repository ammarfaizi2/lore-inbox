Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266074AbRF1SHP>; Thu, 28 Jun 2001 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbRF1SHF>; Thu, 28 Jun 2001 14:07:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24335 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266074AbRF1SGx>; Thu, 28 Jun 2001 14:06:53 -0400
Subject: Re: Cosmetic JFFS patch.
To: rogers@ISI.EDU (Craig Milo Rogers)
Date: Thu, 28 Jun 2001 19:06:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <503.993750710@ISI.EDU> from "Craig Milo Rogers" at Jun 28, 2001 10:51:50 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FgBc-0007Nr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >a non modular build but stuffed into their own section so you can pull them
> >out with some magic that we'd include in 'REPORTING-BUGS'
> 
> 	In a /proc file, maybe?  A single file ("/proc/authors"?
> "/proc/versions"? "/proc/brags"? "/proc/kvell"?)  could present the

/proc/drivers maybe. It just needs to be a compact summry for debugging - 
nothing more.

