Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272338AbTHDXam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272339AbTHDXam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:30:42 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:29342
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S272338AbTHDXal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:30:41 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.60537.766825.122189@wombat.chubb.wattle.id.au>
Date: Tue, 5 Aug 2003 09:30:01 +1000
To: David Lang <david.lang@digitalinsight.com>
Cc: Werner Almesberger <werner@almesberger.net>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
In-Reply-To: <Pine.LNX.4.44.0308041243500.7534-100000@dlang.diginsite.com>
References: <20030804163256.M5798@almesberger.net>
	<Pine.LNX.4.44.0308041243500.7534-100000@dlang.diginsite.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One thing that you could do *if* you cared to go to a SYSVr4
streams-like approach is just to push *some* of the TCP/IP stack onto
the card, as one or more streams modules.

Peter C
