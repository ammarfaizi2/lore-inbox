Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757477AbWK0IxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477AbWK0IxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757480AbWK0IxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:53:05 -0500
Received: from lemon.ertos.nicta.com.au ([203.143.174.143]:61371 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S1757477AbWK0IxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:53:02 -0500
Date: Mon, 27 Nov 2006 19:52:24 +1100
Message-ID: <87d579jmpj.wl%peterc@chubb.wattle.id.au>
From: Peter Chubb <peter@chubb.wattle.id.au>
To: "sudhnesh adapawar" <sudhnesh@gmail.com>
Cc: linux-ia64@vger.kernel.org, lia64-sim@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <9b33a9230611252206l777e3bcfr5795b0b16668183f@mail.gmail.com>
References: <9b33a9230611252206l777e3bcfr5795b0b16668183f@mail.gmail.com>
User-Agent: Wanderlust/2.14.0 (Africa) SEMI/1.14.6 (Maruoka) FLIM/1.14.8 (Shij~) APEL/10.6 MULE XEmacs/21.4 (patch 19) (Constant Variable) (x86_64-linux-gnu)
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 220.237.8.57
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: Re: Ski for huge page size !
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:39:27 +0000)
X-SA-Exim-Scanned: Yes (on lemon.gelato.unsw.edu.au)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "sudhnesh" == sudhnesh adapawar <sudhnesh@gmail.com> writes:

sudhnesh> Hey all !  I am thinking to use ski simulator as I can get
sudhnesh> the ia64 (Itanium 2)simulated on ia32 archi....So can I use
sudhnesh> this product for the project related to huge page size ???
sudhnesh> Will the problems related to huge pages such as
sudhnesh> swapping,IO,etc...will be covered if I use ski with 2.6
sudhnesh> kernel image configured for ia64 archi with huge page size
sudhnesh> support ?????


Should work perfectly.  We've been using Ski for similar work, looking
at SuperPage support.
--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
