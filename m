Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTCBWUK>; Sun, 2 Mar 2003 17:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCBWUK>; Sun, 2 Mar 2003 17:20:10 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:31759 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S261523AbTCBWUK>;
	Sun, 2 Mar 2003 17:20:10 -0500
Date: Sun, 2 Mar 2003 17:30:30 -0500
Message-Id: <200303022230.h22MUUM32283@moisil.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: jp.pozzi@izzop.org
Cc: linux-kernel@vger.kernel.org, Mikael Pettersson <mikpe@user.it.uu.se>
Subject: Re: Bug in APIC on 2.4.20 kernel
In-Reply-To: <1046558538.969.3.camel@k400.jpp.fr>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Mar 2003 23:42:18 +0100, JP Pozzi izzop.org <jp.pozzi@izzop.org> wrote:
> Hello,
> 
> I try the patch with no success, the kernel seems to be ok, but the
> message at boot loops always "APIC CPU0 O4(04)".

The patch only affects a UP kernel. If you compiled your kernel as SMP, 
try again as UP and report back.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
