Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263278AbTJUTNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTJUTNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:13:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40198 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263278AbTJUTNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:13:10 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk se ctors numbered strangely, and what happens to them?)
Date: 21 Oct 2003 12:13:01 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bn40ft$heq$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0310201153150.26888-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.53.0310201204100.13739@chaos> <3F940C42.7080308@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F940C42.7080308@nortelnetworks.com>
By author:    Chris Friesen <cfriesen@nortelnetworks.com>
In newsgroup: linux.dev.kernel
>
> Richard B. Johnson wrote:
> 
> > Battery-backed SRAM "drives" in the gigabyte sizes already exist.
> > Terabytes should not be too far off.
> > 
> > Soon those "drives" will be as cheap as their mechanical emulations
> > and you won't need those metal boxes with the rotating mass anymore.
> > The batteries last about 10 years. Better than most mechanical
> > drives.
> 
> I'm dubious.  Ram costs about 150-200X as much as hard drives.  I don't 
> see that changing.
> 

Not without a completely disruptive technology change, which is always
possible; MRAM is one possibility.

Having nonvolatile storage with access times near current DRAM speeds
and cost/densities near current disk would change the computer
industry in a very fundamental way, not the least because current
operating systems make the memory/disk dichotomy very visible.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
