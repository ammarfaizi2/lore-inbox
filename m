Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318241AbSHDTQO>; Sun, 4 Aug 2002 15:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318243AbSHDTQO>; Sun, 4 Aug 2002 15:16:14 -0400
Received: from p50887FF5.dip.t-dialin.net ([80.136.127.245]:1228 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318241AbSHDTQN>; Sun, 4 Aug 2002 15:16:13 -0400
Date: Sun, 4 Aug 2002 13:19:36 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.30 ACPI: fixing compilation
In-Reply-To: <20020804185827.GA15828@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0208041315130.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 4 Aug 2002, Pavel Machek wrote:
> This fixes compilation and is actually right since we can't get SMP
> machine suspending, anyway.

Did we make sure that we won't suspend on smp? I can't see where that 
happens.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-


