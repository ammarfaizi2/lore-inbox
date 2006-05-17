Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWEQBJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWEQBJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWEQBJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:09:00 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:42448 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751037AbWEQBI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:08:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17514.30622.22763.24688@wombat.chubb.wattle.id.au>
Date: Wed, 17 May 2006 11:08:46 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Ju, Seokmann'" <Seokmann.Ju@lsil.com>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: RE: Help: strange messages from kernel on IA64 platform
In-Reply-To: <4t153d$13ldvv@azsmga001.ch.intel.com>
References: <890BF3111FB9484E9526987D912B261901BD86@NAMAIL3.ad.lsil.com>
	<4t153d$13ldvv@azsmga001.ch.intel.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kenneth" == Kenneth W Chen <Chen> writes:

Kenneth> Ju, Seokmann wrote on Tuesday, May 16, 2006 2:13 PM
>> Tuesday, May 16, 2006 5:00 PM, Chase Venters wrote: > It's a trap,
>> which means the CPU is effectively calling that function.  O.K,
>> that's why...  Then, Is there anyway to look up trap table that the
>> CPU has?

Kenneth> By looking at the instruction address that triggered the
Kenneth> unaligned fault, it is coming from a kernel module.

General details for tracking down unaligned access problems in IA64
linux at http://www.gelato.unsw.edu.au/IA64wiki/UnalignedAccesses
-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
