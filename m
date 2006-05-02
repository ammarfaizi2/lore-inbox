Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWEBMs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWEBMs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 08:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWEBMs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 08:48:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34187 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964797AbWEBMs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 08:48:56 -0400
Date: Tue, 2 May 2006 14:48:55 +0200
From: Martin Mares <mj@ucw.cz>
To: Avi Kivity <avi@argo.co.il>
Cc: Willy Tarreau <willy@w.ods.org>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
Message-ID: <mj+md-20060502.124648.6316.atrey@ucw.cz>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <mj+md-20060502.111446.9373.atrey@ucw.cz> <445741F5.6060204@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445741F5.6060204@argo.co.il>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> But it executed C++ code within a few cycles of entering the reset 
> vector (no standard BIOS), including but not limited to: programming the 
> memory controller (430MX chipset), servicing interrupts, hardware 
> accelerated 2D graphics (C&T 65550), IDE driver, simple filesystem, 
> simple windowing GUI, network driver (Tulip) etc.

I really don't claim it's impossible to write kernels in C++ -- it's
clearly possible given that everything you can do in C, you can do in
C++ as well. But what I argued about is whether kernel programming in C++
can be easier and more efficient, which is why I wanted you to show
some examples. Real code speaks better than thousand theories.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Only dead fish swim with the stream.
