Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278967AbRKMUxP>; Tue, 13 Nov 2001 15:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278962AbRKMUxF>; Tue, 13 Nov 2001 15:53:05 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:63968 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S278958AbRKMUwy>; Tue, 13 Nov 2001 15:52:54 -0500
Date: Tue, 13 Nov 2001 21:52:40 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: fdutils.
In-Reply-To: <3BF185A9.8000200@zytor.com>
Message-ID: <Pine.GSO.3.96.1011113214448.11222E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, H. Peter Anvin wrote:

> >  Hmm, Sun used to have a software-controlled standard floppy drives years
> > ago... 
> 
> I'm not talking about Suns.

 I'm just pointing out there used to be no problem with making a
software-controlled eject for a legacy floppy device even long ago if one
wanted to. 

> >  Based on local obervations hardly anyone uses floppies anymore...  They
> > are mostly used for system rescue purposes, where the kind of a device
> > doesn't really matter.
> 
> ... except that you no longer can fit a reasonable system rescue/install
> setup on a floppy, so it *defintitely* matters.  Also, the floppy device
> is like a rash all over the hardware; it maintains a highly undesirable
> legacy.

 You only confirm what I wrote -- hardly anyone uses floppies, so there is
no need to keep mechanical compatibility in devices -- a complete dump of
1.44" FD support would be almost harmless.  Hence whether a Zip or a
LS-120 -- it doesn't really matter.  You need new media anyway. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

