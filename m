Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLLDIn>; Mon, 11 Dec 2000 22:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbQLLDIe>; Mon, 11 Dec 2000 22:08:34 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:527 "EHLO
	ani.animx.eu.org") by vger.kernel.org with ESMTP id <S129228AbQLLDIY>;
	Mon, 11 Dec 2000 22:08:24 -0500
Date: Mon, 11 Dec 2000 21:46:44 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Jes Sorensen <jes@linuxcare.com>
Cc: Daryll Strauss <daryll@valinux.com>, David Feuer <David_Feuer@brown.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001211214644.C29196@animx.eu.org>
In-Reply-To: <E144O4d-0003vd-00@the-village.bc.nu> <3A3066EC.3B657570@timpanogas.org> <E144O4d-0003vd-00@the-village.bc.nu> <20001209201238.A12452@zorro.pangea.ca> <4.3.2.7.2.20001209213353.00b8bef0@postoffice.brown.edu> <20001209184921.A8495@newbie> <d3aea2ml7r.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <d3aea2ml7r.fsf@lxplus015.cern.ch>; from Jes Sorensen on Tue, Dec 12, 2000 at 03:23:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Daryll> On Sat, Dec 09, 2000 at 09:34:59PM -0500, David Feuer wrote:
> >> For what it's worth, I absolutely agree with this.  I have the same
> >> impression when I just see the word "dangerous".
> 
> Daryll> Why not call a spade a spade and label it BROKEN. I do think
> Daryll> that's stronger than DANGEROUS.
> 
> I doubt it will make any difference whatever we write. I have seen
> several times how users enable every single option because 'they don't
> want to miss out on anything'. It's at the order of someone with a
> Macintosh enabling something labelled "Atari internal serial port
> support" (theoretical example, no offense).

How about reversed?

The option comes enabled by default, but the coding is change to fit this
below:

<M> NTFS support
[*]	disable ntfs write support


But after reading other comments, having it be a forced mount r/w is better. 
(just like I have to force other FS to be mounted r/o instead of default
r/w)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
