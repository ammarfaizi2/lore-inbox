Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTBSVrw>; Wed, 19 Feb 2003 16:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTBSVrv>; Wed, 19 Feb 2003 16:47:51 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:26507 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261900AbTBSVrv>; Wed, 19 Feb 2003 16:47:51 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15955.64983.947830.240943@wombat.chubb.wattle.id.au>
Date: Thu, 20 Feb 2003 08:57:43 +1100
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
In-Reply-To: <20030219073221.GR29983@holomorphy.com>
References: <20030219073221.GR29983@holomorphy.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin, <William> writes:

William> Hi, I have the sam eproblem here, but ACPI is definetly not
William> configured...  Any idea else ?


I see this regularly if I've forgotten to configure in the input layer
or any consoles.  At least one console device has to be in-kernel
otherwise I see the hang mentioned.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
