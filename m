Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270642AbTG1Tvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270658AbTG1Tvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:51:31 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:34782 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S270642AbTG1Tva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:51:30 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Mike Dresser" <mdresser_l@windsormachine.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
Date: Mon, 28 Jul 2003 16:02:57 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGIEIMCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <Pine.LNX.4.56.0307281532230.12115@router.windsormachine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok, what is the DMA device?  Hard drive?  Can you give details?

Mike,

It's a proprietary board that we use to allow the PC to send blocks of data
to some industrial equipment.  We developed the hardware and Linux driver
in-house.  This same board works (under Linux) on a MoBo using the Intel
815E chipset (Pentium III) with an IHC2 I/O Controller Hub.  This is the
system I did _all_ my stress testing in.  The plan was to ship our product
with these ASUS P4PE MoBos (using Intel 845PE and ICH4 controller) and were
un-pleasantly surprise when it didn't work.

Kathy

