Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBTLxX>; Tue, 20 Feb 2001 06:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbRBTLxN>; Tue, 20 Feb 2001 06:53:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13064 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129075AbRBTLxI>; Tue, 20 Feb 2001 06:53:08 -0500
Subject: Re: kernel problems
To: janez@kud-kontrabant.si (Janez Vrenjak)
Date: Tue, 20 Feb 2001 11:53:06 +0000 (GMT)
Cc: linux-alert@redhat.com (linux-alert),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3A923176.3EE76624@kud-kontrabant.si> from "Janez Vrenjak" at Feb 20, 2001 09:57:26 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VBLx-0006RO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello I'm getting this messages all the time.
> After two or three such messages my computer freeses :-(=
> I tried with 2.2, 2.4.0, 2.4.1, 2.4.1ac7-ac18 kernels
> and the same thing happened.
> Does any body have any idea what could be wrong.

Generally its indicative of hardwae when you get dcache corruption especially
with late 2.2, but it might be more complex. Does the box pass memtest86 ?

