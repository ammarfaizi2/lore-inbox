Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTEFPrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTEFPrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:47:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263893AbTEFPrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:47:08 -0400
Date: Tue, 6 May 2003 08:56:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X unlock bug revisited
Message-Id: <20030506085623.4fe97953.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0305061141300.1272-100000@oddball.prodigy.com>
References: <Pine.LNX.4.44.0305061141300.1272-100000@oddball.prodigy.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003 11:50:22 -0400 (EDT) Bill Davidsen <davidsen@tmr.com> wrote:

| Some months ago I noted that a new kernel introduced a failure to be able 
| to unlock X after locking. Still there in 2.5.69 for RH 7.2, 7.3, and 8.0.
| 
| Is there any plan to address whatever causes this problem with a kernel 
| fix, or is a 2.4 kernel still the way to go if you need to lock X. I 
| realize many developers work in environments where there's no need.

This still bites me when I use xscreensaver, so I just use the KDE
screen saver/locker instead.  Eventually the pain level will be too
much, though.

--
~Randy
