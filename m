Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTK2QdR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 11:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTK2QdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 11:33:17 -0500
Received: from ppp-62-245-235-62.mnet-online.de ([62.245.235.62]:46209 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263795AbTK2QdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 11:33:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com>
	<200311281646.40171.s0348365@sms.ed.ac.uk>
	<frodoid.frodo.87zneg8ipo.fsf@usenet.frodoid.org>
	<20031129025500.GA5611@forming>
From: Julien Oster <frodoid@frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Sat, 29 Nov 2003 17:33:08 +0100
In-Reply-To: <20031129025500.GA5611@forming> (Josh McKinney's message of
 "Fri, 28 Nov 2003 21:55:00 -0500")
Message-ID: <frodoid.frodo.87he0njfsr.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh McKinney <forming@charter.net> writes:

Hello Josh,

> I have also been using a A7N8X deluxe and saw lockups when I first
> recieved the board.  Booting with noapic nolapic solved the problems.
> Later after reading some threads about it I decided to add some stuff to
> a bugzilla that someone else already filed.  After doing this I decided
> to try to crash it like it used to to with apic and lapic but it DID NOT
> CRASH!  This may be due to an updated BIOS, I am using the 1007 Uber
> BIOS, or some updates with the kernel, but I am running 2.6.0-test9-mm3
> rock solid with ACPI, APIC, and local APIC.

Oh! That sounds nice. I also run the latest 1007 BIOS, but that
doesn't help at all. In crontrary, I almost have the impression that
the lockups got worse, but that may be just subjective. But what do
you mean with "1007 Uber BIOS"? What is this "Uber"? Is that a special
BIOS Version?

However, 2.6.0-test9-mm3 might be the key. I'll test this immediately.

Thanks,
Julien
