Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278897AbRJVUjK>; Mon, 22 Oct 2001 16:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278895AbRJVUjB>; Mon, 22 Oct 2001 16:39:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63502 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278892AbRJVUis>; Mon, 22 Oct 2001 16:38:48 -0400
Subject: Re: [PATCH] gcc 3.0.1 warnings about multi-line literals
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Mon, 22 Oct 2001 21:45:36 +0100 (BST)
Cc: hawkes@oss.sgi.com (John Hawkes), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20011022161527.K23213@redhat.com> from "Benjamin LaHaise" at Oct 22, 2001 04:15:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vlx2-0003HO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 22, 2001 at 01:05:10PM -0700, John Hawkes wrote:
> > This patch eliminates gcc 3.0.1 warnings, "multi-line string literals are
> > deprecated", in two include/asm-i386 files.  Patches cleanly for at least
> > 2.4.10 and 2.4.12, and tested in 2.4.10.
> 
> Please reject this patch.  The gcc folks are wrong in this case.

Im curious - why do you make that specific claim. The multiline literals are
rather ugly.

Alan
