Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTLLUL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTLLUL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:11:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:28380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbTLLUL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:11:26 -0500
Date: Fri, 12 Dec 2003 12:03:02 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: walt <walt@nea-fast.com>
Cc: marco.roeland@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test11  build error (fs/proc/array.c gcc 2.96 again!)
Message-Id: <20031212120302.6f58dafe.rddunlap@osdl.org>
In-Reply-To: <200312121502.58555.walt@nea-fast.com>
References: <200312121159.23972.walt@nea-fast.com>
	<20031212181314.GA23973@localhost>
	<200312121502.58555.walt@nea-fast.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003 15:02:58 -0500 walt <walt@nea-fast.com> wrote:

| On Friday 12 December 2003 01:13 pm, Marco Roeland wrote:
| > On Friday december 12th 2003 walt wrote:
| > > I got the following when trying to compile 2.6.0-test11. Config is
| > > attached.
| > >
| > > [internal compiler error for fs/proc/array.c]
| >
| 
| Thanks Marco!
| 
| FYI - I removed 
| Kernel .config support (IKCONFIG)
| and it compiled fine.

You disabled IKCONFIG --> with or without applying the patch <-- ??
and it compiled fine...

--
~Randy
MOTD:  Always include version info.
