Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWC2E1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWC2E1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWC2E1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:27:48 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:28873 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750760AbWC2E1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:27:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17450.3208.566621.817647@wombat.chubb.wattle.id.au>
Date: Wed, 29 Mar 2006 15:26:48 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
In-Reply-To: <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
	<4426A5BF.2080804@tremplin-utc.net>
	<200603261609.10992.rob@landley.net>
	<44271E88.6040101@tremplin-utc.net>
	<5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
	<Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
	<36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kyle" == Kyle Moffett <mrmacman_g4@mac.com> writes:


Kyle> But my question still stands.  Does anybody actually use any
Kyle> non-GCC compiler for userspace in Linux?

Yes.  GCC produces much less than optimal code on Itanium, so the
Intel compiler often gets used.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
