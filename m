Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293550AbSBZJey>; Tue, 26 Feb 2002 04:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293554AbSBZJeo>; Tue, 26 Feb 2002 04:34:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51980 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293550AbSBZJej>; Tue, 26 Feb 2002 04:34:39 -0500
Subject: Re: Monolithic Vs. Microkernel
To: lm@bitmover.com (Larry McVoy)
Date: Tue, 26 Feb 2002 09:49:13 +0000 (GMT)
Cc: Rakesh@asu.edu (Rakesh Kumar Banka), linux-kernel@vger.kernel.org
In-Reply-To: <20020225221720.G4924@work.bitmover.com> from "Larry McVoy" at Feb 25, 2002 10:17:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16feET-0008Vc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 25, 2002 at 11:11:59PM -0700, Rakesh Kumar Banka wrote:
> > Anyone working on the Microkernel implementation
> > of Linux? Specially in the area of seperating the process
> > and the file management activities out of the kernel.
> 
> Not if they learned from history, they aren't.  But the Hurd could use
> your help, they're a microkernel.

There are several Linux on microkernel implementations around, thankfully 
using something that can really be called a microkernel. With the "we
want to run 10,000 copies of Linux on a box" market boom it may well prove
to have a practical use one day - as well as the security partitioning one
which some people overlook (and paranoid security people often do not mind
a small performance hit)

Alan
