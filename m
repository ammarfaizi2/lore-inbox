Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131541AbRAKTZr>; Thu, 11 Jan 2001 14:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbRAKTZe>; Thu, 11 Jan 2001 14:25:34 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:24069 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131541AbRAKTZX>; Thu, 11 Jan 2001 14:25:23 -0500
Date: Thu, 11 Jan 2001 14:25:10 -0500
From: Bill Nottingham <notting@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Matthew D. Pitts" <mpitts@suite224.net>, "Robert M. Love" <rml@tech9.net>,
        Giacomo Catenazzi <cate@student.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: Compile error: DRM without AGP in 2.4.0
Message-ID: <20010111142510.A6464@devserv.devel.redhat.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Matthew D. Pitts" <mpitts@suite224.net>,
	"Robert M. Love" <rml@tech9.net>,
	Giacomo Catenazzi <cate@student.ethz.ch>,
	linux-kernel@vger.kernel.org
In-Reply-To: <001101c07bfa$daf36ac0$0100a8c0@pittscomp.com> <E14GmNo-0002lE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14GmNo-0002lE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 11, 2001 at 06:23:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox (alan@lxorguk.ukuu.org.uk) said: 
> > What if your motherboard doesn't have an AGP slot? I'm running an older
> > Micro Star pentium with a ATI All-in-Wonder with the Rage 128 chipset.
> 
> Then I believe you cant use direct render right now

In 4.0.1 r128 DRM sort of worked with a PCI card in an agpgart-supported
motherboard. But not well.

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
