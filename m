Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261753AbSJCPkz>; Thu, 3 Oct 2002 11:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261754AbSJCPky>; Thu, 3 Oct 2002 11:40:54 -0400
Received: from 62-190-202-9.pdu.pipex.net ([62.190.202.9]:6916 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261753AbSJCPkw>; Thu, 3 Oct 2002 11:40:52 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210031551.g93FpwsR000330@darkstar.example.net>
Subject: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 3 Oct 2002 16:51:58 +0100 (BST)
Cc: jgarzik@pobox.com, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, saw@saw.sw.com.sg, rusty@rustcorp.com.au,
       richardj_moore@uk.ibm.com
In-Reply-To: <Pine.LNX.4.44.0209262140380.1655-100000@home.transmeta.com> from "Linus Torvalds" at Sep 26, 2002 09:45:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tangent question, is it definitely to be named 2.6?
> 
> I see no real reason to call it 3.0.
> 
> The order-of-magnitude threading improvements might just come closest to
> being a "new thing", but yeah, I still consider it 2.6.x. We don't have 
> new architectures or other really fundamental stuff. In many ways the jump 
> from 2.2 -> 2.4 was bigger than the 2.4 -> 2.6 thing will be, I suspect.

I think we should stick to incrementing the major number when binary compatibility is broken.

> But hey, it's just a number.  I don't feel that strongly either way. I 
> think version number inflation (can anybody say "distribution makers"?) is 
> a bit silly, and the way the kernel numbering works there is no reason to 
> bump the major number for regular releases.

Psycologically and sub-conciously, this kind of thing _does_ make people stand up and take notice.

For example, SNK made the NeoGeo arcade games print things like:

NEO GEO
MAX 330 MEGA
PRO GEAR SPEC

on start up and in attract mode.

As far as I know, the 330 MEGA means absolutely nothing, and pro gear spec is just an arbitrary name for the addressing system used.

John.

