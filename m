Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUCHPiC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUCHPiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:38:02 -0500
Received: from ccs.covici.com ([209.249.181.196]:28891 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id S262513AbUCHPh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:37:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.37707.806668.409270@ccs.covici.com>
Date: Mon, 8 Mar 2004 10:37:47 -0500
From: John covici <covici@ccs.covici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org
Subject: Re: shuttle an50r Motherboard and Linux
In-Reply-To: <200403081633.38437.bzolnier@elka.pw.edu.pl>
References: <m3wu5w8aex.fsf@ccs.covici.com>
	<200403080151.28816.bzolnier@elka.pw.edu.pl>
	<16460.36222.191866.759421@ccs.covici.com>
	<200403081633.38437.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, here it is.

00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5) (prog-if 8a [Master SecP PriP])
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device a550
	Flags: bus master, 66Mhz, fast devsel, latency 0
	I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2

on Monday 03/08/2004 Bartlomiej Zolnierkiewicz(B.Zolnierkiewicz@elka.pw.edu.pl) wrote
 > On Monday 08 of March 2004 16:13, John covici wrote:
 > > OK, here are the relevant parts of the lspci -v -- I have been using
 > 
 > IDE interface is missed.
 > 
 > > 2.4.22, but if it will make a difference I will try newer ones.
 > 
 > 2.4.x needs update of amd74xx.c driver.  2.6.x should be okay.
 > 
 > Bartlomiej

-- 
         John Covici
         covici@ccs.covici.com
