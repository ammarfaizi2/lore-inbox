Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTKTXcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTKTXcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:32:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1038 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263953AbTKTXci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:32:38 -0500
Date: Thu, 20 Nov 2003 18:21:47 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Michal Semler (volny.cz)" <cijoml@volny.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: HT enable on BIOS which doesn't supports it?
In-Reply-To: <200311181645.02744.cijoml@volny.cz>
Message-ID: <Pine.LNX.3.96.1031120181555.11021E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Michal Semler (volny.cz) wrote:

> Hi, in my laptop Acer TravelMate242 I have HT enabled CPU,
> 
> but when I try start up with SMP or LocalAPIC kernel enabled, kernel freezes 
> during boot time.
> 
> Is there any possibility to run HT enabled CPU on my laptop without BIOS 
> support?

You have HT, but only one sibling. You have the ability to share resources
and no other sibling with whom to share them.

Think of it as a bicycle built for two with only one rider. You can pedal
from either seat but it won't go any faster.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

