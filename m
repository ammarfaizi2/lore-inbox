Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTKKCjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 21:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTKKCjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 21:39:18 -0500
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:12953 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263281AbTKKCjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 21:39:17 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16304.19406.995702.451479@wombat.chubb.wattle.id.au>
Date: Tue, 11 Nov 2003 13:39:10 +1100
To: "Joseph Shamash" <info@avistor.com>
Cc: "Peter Chubb" <peter@chubb.wattle.id.au>, <linux-kernel@vger.kernel.org>
Subject: RE: 2 TB partition support
In-Reply-To: <HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au>
	<HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Joseph" == Joseph Shamash <info@avistor.com> writes:

Joseph> Hello Peter, Forgive another quick Q or two.

Joseph> What is the maximum partition size for a patched 2.4.x kernel,
Joseph> and where are those patches?

See http://www.gelato.unsw.edu.au/IA64wiki/LargeBlockDevices

I've only created a 2.4.20 patch; on my TODO list for the next
fortnight is to create a 2.4.23 patch, as we move towards a 2.4.23
release.

Petre C
