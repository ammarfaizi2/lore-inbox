Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTBCRCj>; Mon, 3 Feb 2003 12:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbTBCRCj>; Mon, 3 Feb 2003 12:02:39 -0500
Received: from [81.2.122.30] ([81.2.122.30]:27140 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266886AbTBCRCi>;
	Mon, 3 Feb 2003 12:02:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302031713.h13HD2K8000181@darkstar.example.net>
Subject: Re: CPU throttling??
To: assembly@gofree.indigo.ie (Seamus)
Date: Mon, 3 Feb 2003 17:13:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1044291313.17360.4.camel@taherias.sre.tcd.ie> from "Seamus" at Feb 03, 2003 04:55:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just a simple question,
> 
> Would it be possible to throttle cpu when machine is in idle mode in
> Linux? or is it purely a BIOS and motherboard functionality.
> 
> As you know some modern laptops in order to save power, throttle cpu
> (lower the cpu clock cycles per sec) when in idle mode.

CPU speed throttling is is something is that is currently being worked
on.

Incidently, Linux has always halted the processor, rather than spun in
an idle loop, which saves power.

John.
