Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270850AbTHOUjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTHOUjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:39:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:56007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270846AbTHOUjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:39:17 -0400
Date: Fri, 15 Aug 2003 13:35:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org
Subject: Re: Centrino support
Message-Id: <20030815133550.33a5918a.rddunlap@osdl.org>
In-Reply-To: <3F3D417A.5090404@lanil.mine.nu>
References: <m2wude3i2y.fsf@tnuctip.rychter.com>
	<1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
	<3F3D417A.5090404@lanil.mine.nu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 22:24:26 +0200 Christian Axelsson <smiler@lanil.mine.nu> wrote:

| Bryan O'Sullivan wrote:
| 
| >If you want built-in wireless in the nearish term, you'll have to get a
| >supported MiniPCI card and replace your Centrino card.
| >
| >  
| >
| Got a list of supported good working cards?

Mini-PCI or CardBus?
I think that some people just add a CardBus wireless card.

| >As far as CPU is concerned, if you're using recent 2.5 or 2.6 kernels,
| >there's Pentium M support in cpufreq.  Jeremy Fitzhardinge has written a
| >userspace daemon that varies the Pentium M CPU frequency in response to
| >load.
| >  
| >
| Can you please point me to this daemon?

http://www.goop.org/~jeremy/speedfreq/

--
~Randy
