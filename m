Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270881AbTGNUuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270878AbTGNUtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:49:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270872AbTGNUrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:47:22 -0400
Date: Mon, 14 Jul 2003 14:00:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][WATCHDOG] 2.4.22 - i810-tco patch
Message-Id: <20030714140017.6f33c3df.rddunlap@osdl.org>
In-Reply-To: <20030713225142.A21148@infomag.infomag.iguana.be>
References: <20030713225142.A21148@infomag.infomag.iguana.be>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003 22:51:42 +0200 Wim Van Sebroeck <wim@iguana.be> wrote:

| Hi Marcelo,
| 
| included a patch against 2.4.22-pre5. It adds support for the 82801EB and 82801ER I/O Controller Hub's (ICH5 & ICH5R). This will add watchdog support for the i865 and i875 motherboard chipsets.
| It also removes some extra trailing spaces in the source files.
| 
| Greetings,
| Wim.

Hi Wim,

Would you also make a version of this patch for 2.6.0-test please?

--
~Randy
