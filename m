Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVEVOgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVEVOgT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 10:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVEVOgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 10:36:19 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5612 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261810AbVEVOgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 10:36:15 -0400
Date: Sun, 22 May 2005 16:36:12 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog/cdrecord replacement
Message-ID: <20050522143612.GC13232@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200505201345.15584.pmcfarland@downeast.net> <105c793f050521182269294d64@mail.gmail.com> <42900929.1000408@khandalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42900929.1000408@khandalf.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2005, Brian O'Mahoney wrote:

> 1--
> SUN uses RPM internally, but continues to insist its Solaris

Can this please move to a Sun vs Linux advocacy group or list?

While Solaris' pkg* is certainly inferior to aptitude/dpkg, what the
heck has this got to do with the Linux kernel?

...
> 2--
> There was little wrong with cdrecord until DVDs came out and
> H Schilling decided to take DVD PRO private and became petty
> about his build system, smake, and others extending a fork
> of cdrecord to support DVDs; which was done by both SuSE and
> Debian -- but with weird add in Copyright, and you can't change
> this, and "Inofficial Version" junk from Schilling.

Check GPL clause 2 a - it was Schilling's right to insist that the
modified versions displayed those notices. If we make a fuss about
netfilter GPL compliance, we must grant that application programmers
make the same fuss about GPL compliance if distributors hack the
versions with inofficial patches.

And there has been a time when I've been using the "vanilla" versions
because the SUSE versions didn't work for me, for reasons I wouldn't
investigate, so I have nothing to complain about. ProDVD being
commercial has fostered alternative free DVD writing software that works
with Linux, so just use it and move on. Pragmatism is sometimes the
option of less resistance. :)

It is true Schilling's unrelated rants (like making GNU make sleep for
15 seconds or such) are tiresome and often fought in places where they
are inappropriate, but his complaints about ide-scsi not working
properly and the Kernel inventing SG_IO for ide-cd and the command
filtering behind it and all that fuss were fundamentally right, if a bit
exaggerated in volume. Let's see what becomes of ide-scsi and all that
as libata takes over parallel ATA devices in the future %-)

-- 
Matthias Andree
