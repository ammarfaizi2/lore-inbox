Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288575AbSAQL6C>; Thu, 17 Jan 2002 06:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288597AbSAQL5w>; Thu, 17 Jan 2002 06:57:52 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:45031 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288575AbSAQL5s>; Thu, 17 Jan 2002 06:57:48 -0500
Date: Thu, 17 Jan 2002 12:54:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Henderson <rth@twiddle.net>,
        Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <20020116151852.B31993@kushida.apsleyroad.org>
Message-ID: <Pine.GSO.3.96.1020117124127.10407A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Jamie Lokier wrote:

> > I've always wondered. Intel made the instruction optional yet there isnt
> > an obvious way to do runtime fixups on it
> 
> Yes there is -- emulation! :-)

 For shared libraries the dynamic linker could choose appropriate images.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

