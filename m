Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbUDPWfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbUDPWc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:32:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:22471 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263909AbUDPW2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:28:48 -0400
Date: Fri, 16 Apr 2004 15:23:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: help not functional in make menuconfig kernel 2.6.3
Message-Id: <20040416152332.3882ed64.rddunlap@osdl.org>
In-Reply-To: <20040416131307.GB6879@atrey.karlin.mff.cuni.cz>
References: <20040416131307.GB6879@atrey.karlin.mff.cuni.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 15:13:07 +0200 Karel Kulhavy wrote:

| Hello
| 
| linux kernel 2.6.3
| Device Drivers -> Character devices
| the following entries have non-functional Help. Symptoms: after
| placing the cursor on < Help > and pressing enter the screen is cleared
| and redrawn again. No help is displayed at all.
| 
| Parallel printer support
| Support for user-space parallel port device drivers
| Texas instruments parallel link cable support
| QIC-02 tape support

I'm using 2.6.5...

All of these config entries have help text and they all work
for me.  Please try a newer kernel.  After all, 2.6.3 is about
2 months old now.

--
~Randy
