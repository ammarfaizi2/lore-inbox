Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272505AbTHFV3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272071AbTHFV33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:29:29 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:1152 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S270967AbTHFV3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:29:16 -0400
Date: Wed, 6 Aug 2003 14:26:31 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: "maf."@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: lp not working
In-Reply-To: <200308061307.03350.maf@epost.de>
Message-ID: <Pine.LNX.4.53.0308061411560.153@bigred.russwhit.org>
References: <200308061307.03350.maf@epost.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Aug 2003, Martin Fahr wrote:

> I had a similar problem. Some more details:
> Onboard parport on a Abit KT7a with VIA KT133a chipset.
> CUPS or lpr did not print on 2.6-* and some 2.5.* but with 2.4.21. Printer is
> a HP DJ520.
> My solution to this problem was to change a BIOS setting: "ECP parallel port
> mode" from 1.9 to 1.7. No problems anymore.
>
Sorry, but that option is not available in my bios setup.
Besides, fixing the problem is usually better than a workaround.

Motherboard: Tyan MPX (S2466-4M) with latest bios.
Chipset: AMD 760MPX, 762, 768, Winbond 83627

Software: Slackware 9.0 with some updates.

Let me know if I can be of any assistance.

Thanks,
  Russ
