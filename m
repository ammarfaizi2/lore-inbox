Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264634AbSKDC5R>; Sun, 3 Nov 2002 21:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264636AbSKDC5Q>; Sun, 3 Nov 2002 21:57:16 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:44531 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S264634AbSKDC5Q>; Sun, 3 Nov 2002 21:57:16 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15813.58257.283506.424581@wombat.chubb.wattle.id.au>
Date: Mon, 4 Nov 2002 14:03:45 +1100
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <551170412@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "linux" == linux  <linux@horizon.com> writes:


linux> While a crash dump to just half of one of those mirrors is
linux> fine, finding it might be a little bit tricky.  And the fact
linux> that the kernel reassembles the mirrors automatically on boot
linux> might make retrieving the data a little bit tricky, too.

What most other unices do is crash dump to a dedicated swap
partition.   LKCD appears to be able to do this.  So the setup of MD
etc., isn't going to affect anything.

Peter C
