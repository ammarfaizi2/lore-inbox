Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbTHZVJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTHZVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:09:23 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:60577
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262047AbTHZVJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:09:21 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16203.52320.380770.801056@wombat.chubb.wattle.id.au>
Date: Wed, 27 Aug 2003 07:08:48 +1000
To: Ani Joshi <ajoshi@unixbox.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Radeon FB in 2.6.0-test4 fails for me
In-Reply-To: <Pine.BSF.4.50.0308261102240.15539-200000@shell.unixbox.com>
References: <16202.57600.498532.587264@wombat.chubb.wattle.id.au>
	<Pine.BSF.4.50.0308261102240.15539-200000@shell.unixbox.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ani" == Ani Joshi <ajoshi@unixbox.com> writes:

Ani> try the attatched patch (its against test4).

The patch fixes the text-mode console, but X still cannot use the
frame buffer (the display with UseFB is skewed, and something appears
to go wrong so that all disc activity stops, and the keyboard stops
responding -- as if interrupts were disabled)

Peter C
