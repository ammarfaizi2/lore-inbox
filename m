Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRDKLsb>; Wed, 11 Apr 2001 07:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132406AbRDKLsV>; Wed, 11 Apr 2001 07:48:21 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18602 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131479AbRDKLsH>; Wed, 11 Apr 2001 07:48:07 -0400
Date: Wed, 11 Apr 2001 13:42:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zdenek Kabelac <kabi@i.am>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <3AD36409.6A956F3A@i.am>
Message-ID: <Pine.GSO.3.96.1010411123424.2984D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Zdenek Kabelac wrote:

> I think it would be wrong if we could not add new very usable features
> to the system just because some old hardware doesn't support it.

 s/old/crappy/ -- even old hardware can handle vsync IRQs fine.  E.g. TVGA
8900C. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

